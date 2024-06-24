import matplotlib.pyplot as plt
import numpy as np
import solob_fun as solob
import pandas as pd

Po = 0.03 * (1.0 / 101.325)  # bar
Pf = 80.0  # 1500 * (1.0 / 101.325)  # bar
Psys = np.linspace(Po, Pf, 100)

# ------------------------- exp data---------------------------
data_exp = pd.read_excel(r'C:\Users\Narmin\Desktop\solob_example.xlsx',
                         sheet_name="BMIm DCA")
Pexp = list(data_exp['Pressure1'])
xexp = list(data_exp['mol1'])

T = 313.15  # K
Y = [1.0]
system = ["CO2", "[BMIm][DCA]"]
system_In_vapor = ["CO2"]
h_CO2_IL = 6.65e06 * (1.0 / 101325)  # bar
xo = 0.01

x_co2 = np.zeros(len(Psys))

for i in range(len(Psys)):
    system_molfrac = solob.solve_solob(T, Psys[i], Y, system, system_In_vapor, h_CO2_IL, xo)
    x_co2[i] = system_molfrac[0]

print(x_co2)
plt.plot(x_co2, Psys, 'b', xexp, Pexp, 'ko')
plt.xlim(0.0, 0.5)
plt.ylim(0.0, 80)
plt.xlabel('x CO2 [mol/mol]')
plt.ylabel('P (bar)')
plt.grid()
plt.show()
