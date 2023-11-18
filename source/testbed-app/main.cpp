// This is an independent project of an individual developer. Dear PVS-Studio, please check it.
// PVS-Studio Static Code Analyzer for C, C++, C#, and Java: http://www.viva64.com


void dumpResources()
{
    const auto skipList = QStringList{}
        << ":/qt-project.org"
        << ":/qpdf";

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
    // dumpResources();

    QQmlApplicationEngine engine;
    engine.load("qrc:/qt/qml/testbed/main.qml");

    if (engine.rootObjects().isEmpty())
        return -1;

    const auto ret_code = QGuiApplication::exec();
    return ret_code;
}
