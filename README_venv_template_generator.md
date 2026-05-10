# Venv Batch Template Generator

A small Windows GUI utility that generates four helper scripts for Python projects:

- `run.bat`
- `pip.bat`
- `shell.bat`
- `doctor.bat`

The goal is to make virtual environments easier to use without constantly activating and deactivating them manually.

Core idea:

```bat
.venv\Scripts\python.exe
```

Each project owns its own Python runtime. The generated scripts call that runtime directly.

---

## Files Generated

### `run.bat`

Runs the project using its local venv.

Supports two launch styles:

```bat
python app.py
```

or:

```bat
python -m desktop_companion
```

The generated version uses:

```bat
.venv\Scripts\python.exe app.py
```

or:

```bat
.venv\Scripts\python.exe -m desktop_companion
```

---

### `pip.bat`

Installs packages into the local project venv.

Instead of:

```bat
pip install requests
```

Use:

```bat
pip.bat install requests
```

This prevents accidental installs into global Python.

---

### `shell.bat`

Opens an activated venv shell for the project.

Use this only when you deliberately want an interactive project shell.

---

### `doctor.bat`

Checks the project environment.

It reports:

- project path
- venv Python executable
- Python version
- pip version
- `pip check`
- entry point status
- requirements file status
- optional PyQt6 WebEngine import test

---

## How To Use The GUI

Run:

```bat
python venv_template_generator.py
```

Then:

1. Select the target project folder.
2. Enter or confirm the project name.
3. Choose the venv folder name, usually `.venv`.
4. Choose the entry type:
   - Python file, e.g. `main.py`
   - Python module, e.g. `desktop_companion`
5. Click **Generate 4 File Set**.

---

## For Module Projects

If you usually launch a project like this:

```bat
python -m desktop_companion
```

Choose:

```text
Python module/package
```

Then enter:

```text
desktop_companion
```

The generated `run.bat` will call:

```bat
.venv\Scripts\python.exe -m desktop_companion
```

---

## First-Time Project Setup

After generating the files, create a venv:

```bat
python -m venv .venv
```

Or enable **Create .venv now** in the GUI.

Then install dependencies safely:

```bat
pip.bat install -r requirements.txt
```

Run the project:

```bat
run.bat
```

Check the environment:

```bat
doctor.bat
```

---

## Recommended Project Layout

```text
my_project/
  .venv/
  requirements.txt
  run.bat
  pip.bat
  shell.bat
  doctor.bat
  main.py
```

---

## Why This Exists

Manual venv activation is easy to forget and confusing when switching between projects.

This utility makes the runtime boundary explicit:

```text
Project A uses Project A\.venv\Scripts\python.exe
Project B uses Project B\.venv\Scripts\python.exe
```

No guessing. No global dependency damage. No broken projects because another project upgraded the wrong package.

---

## PyInstaller Note

If you use PyInstaller, build from inside the project venv or call the venv Python directly:

```bat
.venv\Scripts\python.exe -m PyInstaller your_app.spec
```

That makes the executable capture the correct project dependency stack.
