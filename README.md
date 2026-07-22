# Numerical Approaches to the Three-Body Problem (RKF45)

This repository contains the source code, numerical models, and defense presentation developed for my Bachelor's Thesis in Mathematics at the **University of Calabria (UNICAL)**.

The project focuses on the analytical impossibility and computational resolution of the classical **Three-Body Problem** in physics and celestial mechanics. A system of 12 first-order ordinary differential equations (ODEs) was formulated and solved in **MATLAB** using the adaptive **Runge-Kutta-Fehlberg (RKF45)** method.

---

## 📌 Theoretical Context & Key Topics

* **Analytical Non-solvability:** Historical review of attempts by Newton, Euler, and Lagrange (perturbation methods and 5 stability points).
* **Integrals of Motion & Chaos:** Discussion of Bruns' theorem (lack of sufficient first integrals), Poincaré's deterministic chaos ("butterfly effect"), and the KAM theorem.
* **Numerical Method:** Implementation of the 4th/5th order Runge-Kutta-Fehlberg algorithm with automatic step-size control based on local truncation error estimates.

---

## 🌌 Simulated Case Studies & Applications

The MATLAB implementation simulates and evaluates total mechanical energy preservation across four distinct orbital scenarios:

1. **Isosceles Triangle Configuration:** Three bodies initialized at the vertices of an isosceles triangle.
2. **Equilateral Triangle Configuration:** Symmetrical three-body configuration.
3. **Sun-Earth-Moon System:** Real astronomical modeling and energy stability evaluation of our local system.
4. **Alpha-Beta-Proxima Centauri System:** Simulation of a real triple-star system.

---

## 📁 Repository Contents

* `src/`: MATLAB script files (`.m`) implementing the 12-ODE RKF45 system solver and orbit visualization routines.
* `thesis_document.pdf`: Complete text of the Bachelor's Thesis (*"Approcci numerici per il problema dei tre corpi"*).
* `defense_presentation.pptx`: Slides used during the defense containing **embedded video animations** of the numerical simulations.

---

## 🎓 Academic Details & Credits

* **Degree:** Bachelor's Degree in Mathematics (*Laurea Triennale in Matematica*)
* **Institution:** University of Calabria (UNICAL) — Department of Mathematics and Computer Science
* **Graduation Date:** December 13, 2024
* **Thesis Advisor (Relatore):** Prof. Raffaele Giuseppe Agostino
* **Co-Advisor (Correlatore):** Prof. Francesco Dell'Accio

---

## 👤 Author

**Carlo Maria Piccolo**  
*B.Sc. in Mathematics — University of Calabria*  
* [LinkedIn](https://www.linkedin.com/in/CarloMariaPiccolo)
