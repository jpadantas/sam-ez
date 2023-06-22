# README.md

---

## Real-Time Surface-to-Air Missile Engagement Zone Prediction Using Simulation and Machine Learning
---

### Authors

- Joao P. A. Dantas, dantasjpad@fab.mil.br
- Diego Geraldo, diegodg@fab.mil.br
- Felipe L. L. Medeiros, felipefllm@fab.mil.br
- Marcos R. O. A. Maximo, mmaximo@ita.br
- Takashi Yoneyama, takashi@ita.br

---

### Institutes

- Institute for Advanced Studies
- Aeronautics Institute of Technology

---

### Overview

This project utilizes machine learning techniques and a custom simulation tool to create models for the accurate computation of Engagement Zones (EZ) for Surface-to-Air Missiles (SAMs). The tool allows for faster and more efficient simulations and has potential applications in improving defense strategies and SAM system performance. 

---

### Repository Structure

The repository is divided into the following directories:

- **eda**: Exploratory Data Analysis
- **ann**: Artificial Neural Networks
- **rfr**: Random Forest Regression
- **pr**: Polynomial Regression

---

#### Exploratory Data Analysis (EDA)

This section is used for initial data exploration and analysis.

- `eda/eda.ipynb`: This Jupyter notebook contains all the exploratory data analysis. It is used to understand the underlying patterns and correlations in the data.

---

#### Artificial Neural Networks (ANN)

This section is used to develop and evaluate the performance of artificial neural networks on the SAM EZ data.

- `ann/ann.ipynb`: This Jupyter notebook contains the code to develop and evaluate the artificial neural network models.
- `ann/results`: This directory contains the results of the ANN models split by SAM type:
    - `sam_1` and `sam_2` folders contain respective results for different SAM types.
    - Each SAM folder contains `test` and `training` subdirectories with results of respective datasets.

---

#### Random Forest Regression (RFR)

This section is used to develop and evaluate the performance of the random forest regression models on the SAM EZ data.

- `rfr/rfr.ipynb`: This Jupyter notebook contains the code to develop and evaluate the random forest regression models.

---

#### Polynomial Regression (PR)

This section is used to develop and evaluate the performance of polynomial regression models on the SAM EZ data.

- `pr/pr.ipynb`: This Jupyter notebook contains the code to develop and evaluate the polynomial regression models.
- `pr/pr_builder_kfold.R`: This R script is used for building and evaluating polynomial regression models using k-fold cross validation.

---

### Usage

Each .ipynb file is a Jupyter notebook that contains a part of the analysis or model development. To run them, you will need to have Jupyter installed, along with the necessary libraries used within the notebooks (like numpy, pandas, sklearn, etc.).

The pr_builder_kfold.R script is an R script and can be run using any R environment. It also requires certain R packages, so ensure they are installed before running the script.

---

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
