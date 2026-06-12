# # Arithmetic Calculator — emu8086 Assembly

A simple arithmetic calculator written in x86 Assembly language, designed to run on **emu8086** (8086 microprocessor emulator). It performs basic arithmetic operations on integer inputs using low-level CPU instructions.

---

##  Features

- Addition, Subtraction, Multiplication, and Division
- User input via keyboard
- Result displayed on screen
- Written in pure x86 Assembly (16-bit)

---

##  Requirements

- [emu8086](https://emu8086-microprocessor-emulator.en.softonic.com/) — 8086 Microprocessor Emulator
- Windows OS (emu8086 is Windows-based)

---

##  How to Run

1. Download and install **emu8086**.
2. Clone or download this repository:
   ```
   git clone https://github.com/your-username/your-repo-name.git
   ```
3. Open **emu8086**.
4. Click **File → Open** and select the `.asm` file.
5. Click **Compile** then **Run**.
6. Follow the on-screen prompts to enter numbers and choose an operation.

---

## Project Structure

```
├── calculator.asm    # Main assembly source file
└── README.md         # Project documentation
```

---

##  How It Works

The program uses:
- **INT 21h** — DOS interrupts for input/output
- **AX, BX, CX, DX** registers for arithmetic operations
- **MUL / DIV / ADD / SUB** instructions for calculations

The user enters two numbers, selects an operation, and the result is printed to the console.

---

##  Purpose

This project was built as part of a **Computer Organization / Assembly Language** course to practice low-level programming concepts such as register manipulation, interrupts, and arithmetic instructions on the 8086 processor.

---



**HIDDEN SHADOW**
- GitHub: [@HiddenShadow-glitch](https://github.com/HiddenShadow-glitch)

---

## 📝 License

This project is open source and available under the [MIT License](LICENSE).
