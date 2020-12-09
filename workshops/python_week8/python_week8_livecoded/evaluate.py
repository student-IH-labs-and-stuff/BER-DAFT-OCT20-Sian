def evaluate(df, cls):
    """
    parameters:
    - df: a dataframe ready for machine learning
    - cls: a dictionary with several classfiers

    Returns:
    - 
    """

    accuracies = {}

    for cl in cls:
        sc = StandardScaler()
        X = sc.fit_transform(df_ml.drop('survived', axis=1))
        y = df_ml['survived']

        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=17)


        cl.fit(X_train, y_train)
        pred = cl.predict(X_test)
        # print(classification_report(y_test, pred))
        accuracies[cl.__class__.__name__] = accuracy_score(y_test, pred)
        #print(accuracy_score(y_test, pred))
    return accuracies
