import numpy as np
import matplotlib.pyplot as plt
import scipy.stats as stats


file_path = "log/simulation_log_gaussion.txt"
data = np.loadtxt(file_path)[1:]

# 1. 绘制直方图和正态分布拟合曲线
plt.hist(data, bins=50, density=True, alpha=0.6, color='b', label="Data")
mu, std = np.mean(data), np.std(data)
xmin, xmax = plt.xlim()
x = np.linspace(xmin, xmax, 100)
p = stats.norm.pdf(x, mu, std)
plt.plot(x, p, 'k', linewidth=2, label="Normal fit")
plt.title("Histogram with Normal Fit")
plt.legend()
# plt.show()
plt.savefig('log/gaussian_fit.png')

# 2. QQ 图
stats.probplot(data, dist="norm", plot=plt)
plt.title("QQ Plot")
plt.xlim(-4, 4)
# plt.show()
plt.savefig('log/gaussian_qq.png')

# 3. 正态性检验（Shapiro-Wilk）
shapiro_test = stats.shapiro(data)
print(f"Shapiro-Wilk Test: statistic={shapiro_test.statistic}, p-value={shapiro_test.pvalue}")

# 4. 正态性检验（Kolmogorov-Smirnov）
ks_test = stats.kstest(data, 'norm', args=(mu, std))
print(f"Kolmogorov-Smirnov Test: statistic={ks_test.statistic}, p-value={ks_test.pvalue}")

with open("log/gaussian_test.txt", "w") as f:
    f.write(f"Shapiro-Wilk Test: statistic={shapiro_test.statistic}, p-value={shapiro_test.pvalue}\n")
    f.write(f"Kolmogorov-Smirnov Test: statistic={ks_test.statistic}, p-value={ks_test.pvalue}\n")
