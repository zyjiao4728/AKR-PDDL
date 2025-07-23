# 🦾 Sequential Mobile Manipulation Planning (SMMP) with Augmented Kinematic Representation (AKR)

This repository contains the PDDL files of the experiments described in our paper:  
**"Integration of Robot and Scene Kinematics for Sequential Mobile Manipulation Planning"**  
Ziyuan Jiao, Yida Niu, Zeyu Zhang, Yangyang Wu, Yao Su, Yixin Zhu, Hangxin Liu, and Song-Chun Zhu, In Submission, 2025  
[[website](https://aug-kin-rep.github.io/)][[arxiv](https://aug-kin-rep.github.io/)]

---

## 📋 Overview

We present a Sequential Mobile Manipulation Planning (SMMP) framework that can solve long-horizon multi-step mobile manipulation tasks with coordinated whole-body motion, even when interacting with articulated objects. 

---

## 📦 Installation

Tested on **Ubuntu 22.04**.

### 1. Clone the repository and its submodules

```bash
git clone --recurse-submodules https://github.com/zyjiao4728/AKR-PDDL.git
cd AKR-PDDL
```

If you've already cloned the repo without submodules, you can initialize them separately:

```bash
git submodule update --init --recursive
```

### 2. Build the fast downward library

You can follow the [tutorial](https://github.com/aibasel/downward/blob/main/BUILD.md) to build the fast downward library or simply:

```bash
sudo apt install cmake g++ make python3
cd downward
./build.py
cd ..
```

---

## 🚀 Running the Experiment

To run the main experiment, use the following command:

#### Efficiency Improvement in AKR Domain

You can use [scripts/gen_problem.py](scripts/gen_problem.py) to automatically generate a batch of PDDL pick-and-place problems. More details please refer to the script.

```bash
python scripts/gen_problem.py
```

Next, you can use the following command to solve all the generated problems regarding normal domain and ARK domain.

```bash
python scripts/solve_prob_batch.py <domain-file> <problem-file-dir> <output-dir>
```

For example,
```bash
python scripts/solve_prob_batch.py pddl/picknplace/domains/domain-akr.pddl pddl/picknplace/problems pddl/picknplace/results
```

#### SMMP task in simulated household environment

```bash
./downward/fast-downward.py pddl/smmp-simulation/domain.pddl pddl/smmp-simulation/problem.pddl --search "lazy_greedy([ff()], preferred=[ff()])"
```

#### SMMP task in real household environment

```bash
./downward/fast-downward.py pddl/smmp-realworld/domain.pddl pddl/smmp-realworld/problem.pddl --search "lazy_greedy([ff()], preferred=[ff()])"
```


---

## 🧪 Reproducibility

* Tested on **Ubuntu 20.04**
* Python version: 3.8+

---

## 📁 Repository Structure

```
AKR-PDDL/
├── downward/             # fast downward pddl solver
├── pddl/                 # pddl domain and problem files
├── LICENSE
└── README.md
```

---

<!-- ## 📝 Citation

If you find this work useful, please consider citing:

```
@inproceedings{yourcitation2025,
  title={Your Paper Title},
  author={Author, A. and Collaborator, B.},
  booktitle={Conference on XYZ},
  year={2025}
}
``` -->

---

## 📬 Contact

For questions or issues, feel free to open an issue or contact:
📧 [Ziyuan Jiao](mailto:jiaoziyuan@bigai.ai)

<!-- ---

## 🛠 Acknowledgements

This project uses \[list any third-party libraries or frameworks]. Special thanks to \[contributors, institutions, etc.].

```

Let me know if you'd like this tailored to a specific paper title, directory layout, or experiment type (e.g., RL training, motion planning, control simulation).
``` -->
