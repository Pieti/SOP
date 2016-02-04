from fann2 import libfann
import random
import math

def learn(train_file):
    """
    :param train_file: filename without extensions.
    :return:
    method will create nn called <filename>.net
    and except that <filename>.data exists

    Kaikki arvot on kovakoodattu tällä hetkellä. Voisi olla vapaaehtoisia parametrejä.
    Hidden layerien määrän hallintaan pitää keksiä jokin juttu.
    """
    net_file = train_file + '.net'
    data_file = train_file + '_train.data'

    connection_rate = 1
    learning_rate = 0.5 # learning rate ei saa olla liian suuri, toisaalta liian pienellä oppiminen kestää kauan
    num_input = 2
    num_hidden = 4
    num_output = 1

    desired_error = 0.00005
    max_iterations = 100000
    iterations_between_reports = 1000

    ann = libfann.neural_net()

    # Lue tiedosto
    trainindata = libfann.training_data()
    trainindata.read_train_from_file(data_file)

    # Luo verkon
    ann.create_sparse_array(connection_rate, (num_input, num_hidden, num_hidden, num_output))
    ann.set_learning_rate(learning_rate)

    ann.set_activation_function_output(libfann.SIGMOID_SYMMETRIC_STEPWISE) # Aktivointi funktio
    ann.set_training_algorithm(libfann.TRAIN_INCREMENTAL) # Oppimis algoritmi
    ann.train_on_data(trainindata, max_iterations, iterations_between_reports, desired_error)

    ann.save(net_file)

def test(file):
    """
    :param file:  filename without extensions.
    :return:
    except that <filename>.net and <filename>_test.data exists
    Hardkoodattu kaksi tuloa ja yksi lähtö tulostuksiin
    """
    net_file = file + '.net'
    data_file = file + '_test.data'

    testdata = libfann.training_data()  # Luo olion
    testdata.read_train_from_file(data_file)  # Lukee testi materiaalin joka pitäisi olla eri kuin opetusmateriaali

    inputs = testdata.get_input()
    outputs = testdata.get_output()

    ann = libfann.neural_net()
    ann.create_from_file(net_file)  # Lataa aikaisemmin luotu verkko

    print("MSE ERROR : %.5f" %(ann.test_data(testdata))) # Ilmoittaa verkon virheen testidatalla

    for i in range(len(inputs)): # Tulostaa testidatan läpi
        result = ann.run(inputs[i])
        print("Input: %.2f %.2f, Output %.4f, Excepted %.4f" %(inputs[i][0], inputs[i][1], result[0], outputs[i][0] ))


def createDistanceTestFile(filename, length):
    """
    Esimerkki funktio datan luonnista. Tein ihan itse

    :param filename: desired filename without exteensions
    :param length: How many input, output pairs
    :return:
    """
    inputs = []
    outputs = []
    for i in range(length):
        a = random.uniform(0, 0.707)
        b = random.uniform(0, 0.707)
        c = math.sqrt(math.pow(a, 2) + math.pow(b, 2))
        inputs.append([a, b])
        outputs.append([c])

    data = libfann.training_data()
    data.set_train_data(inputs, outputs)
    #data.scale_input_train_data(-1.0, 1.0)
    #data.scale_output_train_data(-1.0, 1.0)

    data.save_train(filename)

if __name__ == "__main__":
    #createDistanceTestFile("distance_train.data", 100)  # Opetusdata (Tarvitsee tehdä vain kerran)
    #createDistanceTestFile("distance_test.data", 10) # Testaus data
    learn("distance") # Tekee uuden neuroverkon distance_train.datan perusteella ja opettaa sen
    test("distance") # Testaa äsken tehtyä verkkoa distance_test.datalla

