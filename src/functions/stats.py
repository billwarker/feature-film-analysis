import scipy.stats
import numpy as np

def mean_confidence_interval(data, confidence=0.95):
    """
    calculate confidence interval for the mean of an array of data
    returns mean, lower bound, upper bound
    """
    a = 1.0 * np.array(data)
    n = len(a)
    m, se = np.mean(a), scipy.stats.sem(a) # mean, sample error for the mean
    h = se * scipy.stats.t.ppf((1 + confidence) / 2., n-1)
    return m, m-h, m+h