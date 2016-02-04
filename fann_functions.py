from fann2 import libfann


def learn():
    connection_rate = 1
    learning_rate = 0.7 # learning rate ei saa olla liian suuri, toisaalta liian pienellä oppiminen kestää kauan
    num_input = 2
    num_hidden = 4
    num_output = 1

    desired_error = 0.0001
    max_iterations = 100000
    iterations_between_reports = 1000

    ann = libfann.neural_net()

    # Lue tiedosto
    trainindata = libfann.training_data()
    trainindata.read_train_from_file('xor_train.data')

    # Luo verkon
    ann.create_sparse_array(connection_rate, (num_input, num_hidden, num_output))
    ann.set_learning_rate(learning_rate)

    ann.set_activation_function_output(libfann.SIGMOID_SYMMETRIC_STEPWISE) # Aktivointi funktio
    ann.set_training_algorithm(libfann.TRAIN_INCREMENTAL) # Oppimis algoritmi
    ann.train_on_data(trainindata, max_iterations, iterations_between_reports, desired_error)

    ann.save("xor.net")

def test():
    testdata = libfann.training_data() # Luo olion
    testdata.read_train_from_file('xor_test.data') # Lukee testi materiaalin joka pitäisi olla eri kuin opetusmateriaali

    inputs = testdata.get_input()
    outputs = testdata.get_output()

    ann = libfann.neural_net()
    ann.create_from_file("xor.net") # Lataa aikaisemmin luotu verkko

    print("MSE ERROR : %.2f" %(ann.test_data(testdata))) # Ilmoittaa verkon virheen testidatalla

    for i in range(len(inputs)): # Tulostaa testidatan läpi
        result = ann.run(inputs[i])
        print("Input: %d %d, Output %.4f, Excepted %d" %(inputs[i][0], inputs[i][1], result[0], outputs[i][0] ))


if __name__ == "__main__":
    learn() # Kutsutaan jatkossa parametreillä.
    test()
