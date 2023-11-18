// This is an independent project of an individual developer. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++, C#, and Java: http://www.viva64.com


void dumpResources()
{
    const auto skipList = QStringList{}
        << ":/qt-project.org"
        << ":/qpdf";

    qInfo() << "\nProject resources: ";
    for (auto it = QDirIterator{":", QDirIterator::Subdirectories}; it.hasNext();)
    {
        const auto & path = it.next();
        const auto skip = std::ranges::any_of(skipList, [&](const auto & prefix)
            {
                return path.startsWith(prefix);
            });
        if (skip)
            continue;

        qInfo() << path;
    }
}


int main(int argc, char * argv[])
{
    QGuiApplication app{argc, argv};

    QGuiApplication::setApplicationDisplayName(APP_NAME);
    QGuiApplication::setWindowIcon(QIcon{"qrc:/assets/logo.png"});

    assert(!QGuiApplication::windowIcon().isNull());

    QQmlApplicationEngine engine;
    engine.load("qrc:/qt/qml/dsazonoff/com/testbed/main.qml");

    if (engine.rootObjects().isEmpty())
    {
        dumpResources();
        return -1;
    }

    const auto ret_code = QGuiApplication::exec();
    return ret_code;
}
