from pyAudioAnalysis import audioBasicIO
from pyAudioAnalysis import audioFeatureExtraction
from pyAudioAnalysis import audioSegmentation
from pyAudioAnalysis import audioTrainTest
from sklearn.preprocessing import Imputer
from sklearn.preprocessing import StandardScaler
import numpy as np
import pandas as pd
import glob
from matplotlib.mlab import PCA
from sklearn import decomposition
from sklearn.cluster import KMeans
S= []
S1 = []


for filename in glob.glob("C:\Users\karun\Desktop\mixed_signal_possnr\*.wav"):
    [Fs, x] = audioBasicIO.readAudioFile(filename);
    F = audioFeatureExtraction.stFeatureExtraction(x, Fs, 0.050*Fs, 0.025*Fs);
    T = F[:,0:65]
    X  = T.flatten()
    S.append(X)
    final_matrix = np.vstack(S)
np.isnan(final_matrix.any())
np.isfinite(final_matrix.all())
Z = Imputer().fit_transform(final_matrix)

np.savetxt("C:\Users\karun\Desktop\csv_python\SNR_Labelled_Data_possnr.csv", Z, delimiter=",")

for filename in glob.glob("C:\Users\karun\Desktop\mixed_signal_negsnr\*.wav"):
    [Fs1, x1] = audioBasicIO.readAudioFile(filename);
    F1 = audioFeatureExtraction.stFeatureExtraction(x1, Fs1, 0.050*Fs1, 0.025*Fs1);
    T1 = F1[:,0:65]
    X1  = T1.flatten()
    S1.append(X1)
    final_matrix = np.vstack(S1)
np.isnan(final_matrix.any())
np.isfinite(final_matrix.all())
Z1 = Imputer().fit_transform(final_matrix)

np.savetxt("C:\Users\karun\Desktop\csv_python\SNR_Labelled_Data_negsnr.csv", Z, delimiter=",")


