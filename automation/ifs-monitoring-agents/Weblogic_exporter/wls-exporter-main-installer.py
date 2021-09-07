def wlDeploy(username, password, adminURL, appName, appPath):
    try:
        connect('TEST','T0EAbcG4Ehghgsu0VwIV','t3://10.241.106.5:48090')
        #start edit operation
        edit()
        startEdit()
        progress = deploy('wls-exporter','E:/wls-exporter/wls-exporter.war',targets='MainServer1',upload='true')
        progress.printStatus()
        save()
        activate(20000,block="true")
        disconnect()
        exit()
    except Exception, ex:
        print ex.toString()
        cancelEdit('y')
wlDeploy('TEST','T0EAbcG4Ehghgsu0VwIV','t3://10.241.106.5:48090','wls-exporter','E:/wls-exporter/wls-exporter.war')