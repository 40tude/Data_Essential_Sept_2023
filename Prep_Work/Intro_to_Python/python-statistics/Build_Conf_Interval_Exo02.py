# Open the monthly_spending_adwords.xlsx file
import os
import pandas as pd

#MyPath = os.getcwd()
cwd = os.getcwd()
MyPath = os.path.dirname(os.path.realpath(__file__))
os.chdir(MyPath)


Data = pd.read_excel (MyPath + "/Monthly spending on adwords.xlsx")
Data.head()

# Calculate the mean and standard deviation of the corresponding column.
Mean = Data.iloc[:, 0].mean()
print(f"Moyenne des dépenses mensuelles : {Mean:.2f} (€)")

Std = Data.iloc[:, 0].std()
print(f"Ecart type (standard déviation) : {Std:.2f} (€)")


# We would like to know the mean of the total population. Calculate the 95% confidence interval.
# Since n>30, t=Z score
# E = t * s/sqrt(n)
# 95% confidence level => Z = 1.96
E = 1.96 * Std/(len(Data)**.5)
print(f"Intervale de confiance à 95% : [{Mean-E:.2f} , {Mean+E:.2f}]")



# Let's make a test with the studend distribution since 31 is close to 30
# On https://statdistributions.com/t/ we determine t when p=0.05 (95% confidence interval)
# t = 2.228
E = 2.228 * Std/(len(Data)**.5)
print(f"Intervale de confiance à 95% : [{Mean-E:.2f} , {Mean+E:.2f}]")


os.chdir(cwd)
