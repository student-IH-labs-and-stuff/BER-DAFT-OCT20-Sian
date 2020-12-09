from sklearn.neural_network import MLPClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.svm import SVC
from sklearn.gaussian_process import GaussianProcessClassifier
from sklearn.gaussian_process.kernels import RBF
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier, AdaBoostClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis

from tqdm.notebook import tqdm

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import plot_confusion_matrix, classification_report, accuracy_score

import matplotlib.pyplot as plt


def evaluate(df, cls, tqdm_off=True):
    """ What this function does
    Parameters:
        df: a pandas dataframe of the titanic dataset ready to do ML with. Must contain
        column 'survived' as label column
        cls: a list of Supervised learning classifiers from sklearn
        tqdm_off: Wether support of tqdm should be off. If False, a progress bar for the
        classifier iteration is generated
    Returns:
        accuracies: a dictionary of the form {<classifier_name>:<accuracy_score>}
    """



    # Defining an accuracy dictionary which will be the result of the dataframe
    # of the format {<name_of_classifier>:<score>}
    accuracies = {}

    # Looping through all classifiers
    for cl in tqdm(cls, disable=tqdm_off):
        sc = StandardScaler()

        # Define features and labels
        X = sc.fit_transform(df.drop('survived', axis=1))
        y = df['survived']

        # Train test split
        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42)

        # Fit model
        cl.fit(X_train, y_train)

        # Predict new labels best on test features
        pred = cl.predict(X_test)

        # Add calculated accuracy score together with corresponding classifier name to dictionary
        accuracies[cl.__class__.__name__] = accuracy_score(y_test, pred)

        # Display confusion matrix
        disp = plot_confusion_matrix(cl, X_test, y_test,
                                     cmap=plt.cm.Blues,
                                     display_labels=["Not Survived", "Survived"],
                                    )
        # Set title of confusion matrix depending on current classifier name
        disp.ax_.set_title(f'Confusion matrix \n {cl.__class__.__name__} \n with engineered features')

    return accuracies
