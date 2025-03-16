# R Assignemtn -- Zheyuan Zhang
# **Genotype Data Analysis and Visualization**

This project processes and visualizes SNP genotype data from maize and teosinte populations. The workflow includes data cleaning, transformation, and various visualizations to explore the distribution of SNPs across chromosomes, genotype proportions, and missing data patterns.

---

## **📂 Files**
- `fang_et_al_genotypes.txt` - Raw genotype data for different maize and teosinte samples.
- `snp_position.txt` - SNP position data mapping SNPs to chromosomes.

---

## **🛠️ Workflow**
### **1️⃣ Data Processing**
- Read genotype and SNP position files.
- Remove unnecessary columns (`JG_OTU`).
- Separate maize and teosinte groups.
- Transpose the genotype data for each group.
- Merge genotype data with SNP position data.
- Generate sorted SNP files (increasing and decreasing order) for both maize and teosinte.

### **2️⃣ Data Transformation**
- Convert genotype data into **long format** for visualization.
- Standardize chromosome names, handling **unknown and multiple** values.
- Convert **position data to numeric** for proper ordering.

---

## **📊 Visualizations**
### **1️⃣ SNP Distribution Across Chromosomes**
- **Bar plot** showing the number of SNPs per chromosome for maize and teosinte.

### **2️⃣ SNP Density Along Chromosomes**
- **2D bin density plot** displaying SNP positions along chromosomes.

### **3️⃣ Genotype Proportion per Sample**
- **Stacked bar plot** visualizing the proportion of `homozygous`, `heterozygous`, and `missing` SNPs per sample, faceted by maize and teosinte groups.

### **4️⃣ Genotype Distribution Across Chromosomes**
- **Stacked proportional bar plot** showing the relative proportions of `homozygous`, `heterozygous`, and `missing` SNPs per chromosome.

---

## **📦 Output Files**
- `maize_data/maize_chromX_increase.txt` - SNPs in **ascending order** for chromosome X.
- `maize_data/maize_chromX_decrease.txt` - SNPs in **descending order** for chromosome X.
- `teosinte_data/teosinte_chromX_increase.txt` - SNPs in **ascending order** for chromosome X.
- `teosinte_data/teosinte_chromX_decrease.txt` - SNPs in **descending order** for chromosome X.

---

## **📌 Requirements**
This analysis is conducted in **R** using the following packages:
```r
library(tidyverse)
library(ggplot2)
