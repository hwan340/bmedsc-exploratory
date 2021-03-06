function processed = processMnistBraille(imOriginal,scale, mnistModel)
%PROCESSMNISTBRAILLE Processes a colour image to a binary, downsampled
%image, converting digits to their Braille representation using a
%pre-trained multiclass SVM image classifier. This will ONLY work with the
%MNIST dataset and expects a matrix with dimensions [28, 28] and values in
%the range 0 and 1.
%   processed = PROCESSMNISTBRAILLE(imOriginal, scale) takes a 
%   (height, width, 3) image and a float scale (between 0 and 1) and 
%   returns a (height/scale, width/scale) binary image.

% MUST be 28 x 28!
[nX, nY] = size(imOriginal);

% Reshape the MNIST image to a row vector (as expected for the SVM)
imInput = reshape(imOriginal, [1, nX * nY]);

% Predict
prediction = predict(mnistModel, imInput);

% Cell array of digits to braille
% Can this be moved outside of function for optimisation?
digitToBraille = {};
digitToBraille{'1'} = [1 0; 0 0];
digitToBraille{'2'} = [1 0; 1 0];
digitToBraille{'3'} = [1 1; 0 0];
digitToBraille{'4'} = [1 1; 0 1];
digitToBraille{'5'} = [1 0; 0 1];
digitToBraille{'6'} = [1 1; 1 0];
digitToBraille{'7'} = [1 1; 1 1];
digitToBraille{'8'} = [1 0; 1 1];
digitToBraille{'9'} = [0 1; 1 0];
digitToBraille{'0'} = [0 1; 1 1];

% Output image as a 2x2 matrix
outputXdim = 2;
outputYdim = 2;
imOutput = digitToBraille{num2str(prediction)};

% Upscale back, assuming nX == nY, to a binary image
processed = imresize(imOutput, ((nX * scale) / outputXdim), "nearest");

end

