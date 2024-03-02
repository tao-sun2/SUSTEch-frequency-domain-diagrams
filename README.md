# SUSTEch-frequency-domain-diagrams

The code of MATLAB for frequency-domain diagrams of article `Ultrafast piezocapacitive soft pressure sensors with over 10 kHz bandwidth via bonded microstructured interfaces`.


### 1. `wavelet_transformation.m`

#### Overview

The Matlab script primarily focuses on data import, signal processing, and wavelet-based time-frequency analysis. It also conducts high-pass filtering to remove noise and performs data visualization.

#### Dependencies

- Matlab Signal Processing Toolbox
- Excel, for data export

#### Functionality Breakdown

1. **Data Import**: Reads time and amplitude from a text file.
2. **Data Preprocessing**: Prepares data for FFT analysis.
3. **Fourier Analysis**: Executes FFT and visualizes amplitude spectrum.
4. **Filter Design**: Creates a Butterworth high-pass filter.
5. **Filter Application**: Applies the designed filter to the signal.
6. **WSST Analysis**: Performs Wavelet Synchrosqueezed Transform for time-frequency representation.
7. **Data Visualization**: Plots processed data and WSST results.
8. **Data Export**: Saves processed data to an Excel file.

#### Usage

The script can be run in a Matlab environment. Make sure to place the '1000Hz.txt' file in the specified directory path. To export data, ensure the target directory for the Excel file exists or modify the script to fit your directory structure.