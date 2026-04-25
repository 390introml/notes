# 6.390 Notation and Style Guide

Consistent notation across all course materials: notes, exams, labs, homework, and recitations. If in doubt, the course notes and most recent exams are the canonical reference.

## Mathematical Notation Conventions

### Training Data
- Data points indexed with **superscript in parentheses**: `x^{(i)}, y^{(i)}` or `\ex{x}{i}, \ex{y}{i}`
- Dataset: `\data = \{(\ex{x}{i}, \ex{y}{i})\}_{i=1}^n`
- `n` = number of training examples, `d` = input dimension
- Feature components use **subscripts**: `x_1, x_2, x_j`

### Vectors and Matrices
- **Vectors**: bold lowercase via `\mathbf{}` -- e.g., `\mathbf{x}`, `\bx`
- **Matrices**: plain uppercase -- e.g., `X, W, A`
- **Transpose**: `X^T` or `\theta^T`
- Column vectors by default; `\theta^T x` for dot products
- Dimensions stated explicitly: `X \in \R^{n \times d}`, `\theta \in \R^d`

### Parameters and Weights
- Linear model: `\theta` (weights), `\theta_0` (intercept/bias)
- Neural network layers: `W^{(l)}` (weight matrix), `W_0^{(l)}` or `b^{(l)}` (bias), with **superscript in parens for layer index**
- ML estimate: `\ml{\theta}` renders as `\theta_{ml}`
- ERM estimate: `\erm{\theta}` renders as `\theta_{erm}`
- Model variant labels: `\theta^{\mathrm{multi}}`, `\theta^{\mathrm{bin}}`

### Functions
- **Hypothesis**: `h(x; \theta, \theta_0)` -- semicolon separates input from parameters
- **Loss**: `\mathcal{L}(g, y)` for general loss; specific variants `\mathcal{L}_{\text{nll}}`, `\mathcal{L}_{\text{SE}}`
- **Objective**: `J(\theta)` or `J(\theta, \theta_0)`
- **Sigmoid**: `\sigma(z) = \frac{1}{1 + e^{-z}}`
- **Softmax**: `\operatorname{softmax}`
- **ReLU**: `\text{ReLU}(z) = \max(0, z)` -- capitalize "ReLU" in text
- **Feature transform**: `\phi(x)` for transformed feature vector

### Neural Networks
- Pre-activation: `Z^{(l)} = (W^{(l)})^T A^{(l-1)} + W_0^{(l)}`
- Post-activation: `A^{(l)} = f^{(l)}(Z^{(l)})`
- Input: `A^{(0)} = x`
- Activation functions: `f^{(l)}(\cdot)` per-layer

### Gradients
- Gradient operator: `\nabla_\theta J(\theta)`
- Partial derivatives: `\frac{\partial J}{\partial \theta}`
- Gradient descent update: `\theta^{(t)} = \theta^{(t-1)} - \eta \nabla_\theta J(\theta^{(t-1)})`

### Attention Mechanism
- Queries/keys/values: `q_i = W_q^T x_i`, `k_j = W_k^T x_j`, `v_j = W_v^T x_j`
- Attention scores: `s_{ij} = q_i \cdot k_j`
- Softmax'd attention scores: `\alpha_{ij} = \frac{e^{s_{ij}}}{\sum_l e^{s_{il}}}` (explicit softmax formula) -- do NOT call these "attention weights"
- Output: `z_i = \sum_j \alpha_{ij} v_j`

### CNNs
- Filter/kernel: lowercase `f` or `F`, shown as small matrices
- Output size: `(\text{input} - \text{filter} + 2\text{padding}) / \text{stride} + 1`
- Receptive field: set notation `\{(i,j), \ldots\}`

### MDPs and Reinforcement Learning
- **States**: lowercase `s` with subscripts (`s_0, s_1, s_2`) or tuples (`(p, m)`)
- **Actions**: lowercase `a`; named actions in `\text{}`: `\text{Forward}`, `\text{cash out}`
- **State space**: `\mathcal{S}`, **action space**: `\mathcal{A}`
- **Reward function**: `\mathrm{R}(s, a)` -- upright R
- **Transition function**: `\mathrm{T}(s, a, s')` -- upright T
- **Discount factor**: `\gamma \in (0, 1)`
- **Horizon**: `h`
- **Optimal value function**: `\mathrm{V}^*_h(s)` (finite horizon), `\mathrm{V}^*_\infty(s)` or `\mathrm{V}^*(s)` (infinite horizon) -- upright V
- **Optimal Q-function**: `\mathrm{Q}^*_h(s, a)` (finite horizon), `\mathrm{Q}^*_\infty(s, a)` (infinite horizon) -- upright Q
- **Policy value function**: `\mathrm{V}^\pi(s)`
- **Policy**: `\pi` or `\pi(s)`; greedy policy: `\pi^*(s) = \arg\max_a \mathrm{Q}^*(s, a)`
- All MDP functions (`\mathrm{R}`, `\mathrm{T}`, `\mathrm{V}`, `\mathrm{Q}`) use **upright** (`\mathrm{}`) letters
- **Value iteration (Bellman equation)**:
  `\mathrm{V}^*_{h+1}(s) = \max_a [\mathrm{R}(s,a) + \gamma \sum_{s'} \mathrm{T}(s,a,s') \mathrm{V}^*_h(s')]`
- **Q-value Bellman equation**:
  `\mathrm{Q}^*_{h+1}(s,a) = \mathrm{R}(s,a) + \gamma \sum_{s'} \mathrm{T}(s,a,s') \max_{a'} \mathrm{Q}^*_h(s',a')`
- **V-Q relationship**: `\mathrm{V}^*(s) = \max_a \mathrm{Q}^*(s, a)`
- **Q-learning update**: `\mathrm{Q}(s,a) \leftarrow \mathrm{Q}(s,a) + \alpha [r + \gamma \max_{a'} \mathrm{Q}(s',a') - \mathrm{Q}(s,a)]`
- **Learning rate** (Q-learning): `\alpha`
- **Epsilon-greedy**: `\varepsilon`-greedy
- **Deep RL / DQN**: neural network Q-function `Q_\theta(s,a)`, policy network `\pi_\theta`
- **DQN target**: `y = r + \gamma \max_{a'} Q_\theta(s',a')`
- **DQN loss (Bellman error)**: `\mathcal{L}(\theta) = \mathbb{E}[(y - Q_\theta(s,a))^2]`

### Other Conventions
- Learning rate: `\eta`
- Regularization: `\lambda`
- Norms: always use `\norm{\cdot}`, never raw `||`
- Absolute value: always use `\abs{\cdot}`, never raw `|`
- Sets: calligraphic `\mathcal{}` -- `\data`, `\model`, `\mathcal{H}`
- Real numbers: `\R` (renders `\mathbb{R}`)
- Iteration/time index: superscript in parens `\theta^{(t)}`

## LaTeX Macros

These custom macros are used across course materials. Any shared `.sty` or preamble should define them.

| Macro | Expansion | Usage |
|-------|-----------|-------|
| `\R` | `\mathbb{R}` | Real numbers |
| `\bx` | `\mathbf{x}` | Bold x vector |
| `\ex{x}{i}` | `x^{(i)}` | i-th example |
| `\data` | `\mathcal{D}` | Dataset |
| `\model` | `\mathcal{M}` | Model class |
| `\norm{\cdot}` | `\|\cdot\|` | Norm |
| `\abs{\cdot}` | `|\cdot|` | Absolute value |
| `\ml{\theta}` | `\theta_{ml}` | ML estimate |
| `\erm{\theta}` | `\theta_{erm}` | ERM estimate |

## Writing Style

- Use **"Calculate"** when asking for numerical answers
- Use **"Write out"**, **"Express"**, or **"Derive"** when asking for general expressions or symbolic formulas
- Explanation prompts: use **"Briefly explain:"** (not "Explanation:" or other variants)
- Problems use narrative framing (Alice/Bob arguments, scenario-based setups)
- Parts escalate in difficulty within a problem
- Solutions include brief explanations, not just answers

## Topic Coverage (Spring 2026)

Introductory material, linear regression, ridge regularization, gradient descent, binary/multi-class logistic regression, neural networks, CNNs, attention, MDPs, and reinforcement learning.
