# HDI_XML_Commands_thread_safe

Demonstrates that 4D's DOM XML commands can be called safely from preemptive processes, and stress-tests that guarantee with concurrent, multi-worker XML comparisons. Originally published by 4D as a **HDI** (*How Do I*) example for **4D v16**; converted from the binary `.4DB` to the `.4DProject` architecture so it runs on current 4D releases.

## What it demonstrates

- Creating a `DOM XML Ref` in one process and safely reading/writing it from another, both cooperative and preemptive, via `CALL WORKER`.
- Comparing two XML documents by parsing them into DOM trees and walking them recursively, in a form that is safe to call from a preemptive worker.
- Running the same comparison concurrently across several workers to stress-test thread safety, with a simple wait/poll loop and elapsed-time reporting.
- Detecting 32-bit vs. 64-bit and compiled vs. interpreted mode at `On Load` and disabling controls that require preemptive process support accordingly.

## Key commands

| Command | Used for |
|---|---|
| `DOM Create XML Ref` / `DOM Create XML element` / `DOM SET XML ELEMENT VALUE` | Building the sample XML document used throughout the demo |
| `DOM EXPORT TO FILE` / `DOM EXPORT TO VAR` | Writing the DOM tree to disk or into a form variable for display |
| `DOM Parse XML source` | Loading an XML document into a DOM ref for comparison or re-use |
| `DOM GET XML CHILD NODES` / `DOM Count XML attributes` / `DOM GET XML ATTRIBUTE BY INDEX` | Walking a DOM tree node-by-node and attribute-by-attribute to compare two documents |
| `DOM CLOSE XML` | Releasing a DOM ref once parsing/comparison is done |
| `CALL WORKER` / `KILL WORKER` | Running the XML ref hand-off and the comparison stress test on named background workers |
| `Process state` / `Version type` / `Is compiled mode` | Polling worker completion and branching behaviour by architecture/mode |

## How it works

The startup method `Project/Sources/Methods/00_Start.4dm` opens the standard `HDI` splash form; its `BtnDemo` object method opens the real demo form `HDI2` in a dialog.

`HDI2/method.4dm` builds a sample XML ref on `On Load` via `m_createAnXMLref`, exports it to `theXmlFile.xml`, and re-parses it into the form variable `refXML`. Page 1 of the form ("Send a ref to another process") lets you pick **Cooperative process** or **Preemptive process** with a radio button, then the `Button.4dm` object method hands `refXML` to `m_workOnTheXmlRefCoop` or `m_workOnTheXmlRefPreemp` via `CALL WORKER`. Each of those methods tries to create a child element on the ref it was given and writes the result back to `theXmlFile.xml` — succeeding safely from either process type is the point of the demo.

Page 2 ("Compare in cooperative" / "Compare in preemptive") drives `m_compareXMLtrees`, which lists the sample files under `Resources/FilesXML`, spins up `nbWorker` named workers (`Worker0`, `Worker1`, ...), and hands each one a file to compare against itself `nbLoop` times via `secondLoopCoop`/`secondLoopPreem` — thin, one-liner wrappers around `secondLoop` whose only difference is their `preemptive` method attribute. Each loop iteration calls `CompareFilesXML_DOM`, which parses both files with `DOM Parse XML source` and recurses through them with `CompareXML_DOM`, comparing child node types, attributes, and text values (ignoring superficial differences like decimal separators and comment/whitespace-only nodes via `CleanupText`/`SimplifyText`). The launcher method polls `Process state` on all worker process IDs until they've all returned to `Waiting for user event`, then reports the elapsed time back to the form through `m_updateVar` via `CALL FORM`.

Start with `HDI2/method.4dm` to see the two demo paths, then follow `Button.4dm` for the ref hand-off or `Button2.4dm`/`Button3.4dm` for the comparison stress test.

## Points of interest

- The whole point of the demo is that DOM XML refs and DOM commands are safe to use from preemptive processes — something that was not always true in older 4D versions, hence the original blog post title.
- `m_workOnTheXmlRefPreemp` and `m_workOnTheXmlRefCoop` are otherwise-identical methods distinguished only by their `preemptive` method attribute (`"capable"` vs. default) and an extra warning `ALERT` on the preemptive path; likewise `secondLoopPreem`/`secondLoopCoop` are one-line wrappers that just forward to `secondLoop` under different attributes. This is the simplest way to prove a method behaves correctly under both execution models without duplicating logic.
- `CompareXML_DOM` recurses per XML element and is intentionally written to be side-effect-free per call so it can safely run inside a preemptive worker.
- The 32-bit/64-bit and compiled/interpreted checks in `HDI2/method.4dm` exist because preemptive processes have historically had platform-specific caveats; the form hides the relevant controls instead of failing at runtime.

## Origin

This project started as a binary `.4DB` example database originally distributed with 4D v16. It was converted to the modern project architecture (`.4DProject`) using 4D 21's built-in binary-to-project conversion tool, then modernised (XLIFF localisation, `var`/`#DECLARE` syntax, standard menu actions, method visibility, a rebuilt startup dialog, and dark mode/Liquid Glass CSS) with the help of **GitHub Copilot**, guided by the instruction files under [`.github/instructions/`](.github/instructions/).

- **Blog post:** https://blog.4d.com/xml-commands-are-now-thread-safe/
- **Original download:** https://download.4d.com/Demos/4D_v16/HDI_ThreadSafe_XMLCommands.zip
