pyenv('Version', 'C:\Users\evank\anaconda3\envs\matlab\python.exe')

disp(char(py.str("Hello from Python")))


A = rand(1, 5);
npA = py.numpy.array(A);

mean_val = py.numpy.mean(npA);
mean_in_matlab = double(mean_val);

disp(mean_in_matlab)

