clear
close all

%% Fetch data
load("data_all.mat")
data_all = load("data_all.mat");

%% Chunk data
dataChunks = chunkData(data_all,1);
train_set = dataChunks(1).trainv;
train_label = dataChunks(1).trainlab;
test_set = dataChunks(1).testv;
test_lab = dataChunks(1).testlab;

%% Make predictions
startTime = clock;

preds = KNN(train_set, train_label, test_set, 1);

endTime = clock;
timeTaken = endTime-startTime;

%% Calculate confusion matrix and error rate
confMatKort = calculateConfusionMatrix(preds,dataChunks(1).testlab);
errorRateKort = calculateErrorRate(confMatKort);
confusionchart(confMatKort);

for i = 1:length(preds)
    if preds(i) ~= test_lab(i)
        img = test_set(i,:);
        plotImg(img, preds(i), test_lab(i), "false");
        w = waitforbuttonpress;
    else
        img = test_set(i,:);
        plotImg(img, preds(i), test_lab(i), "correct");
        w = waitforbuttonpress;
    end
end
