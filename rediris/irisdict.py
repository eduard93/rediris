import irisnative

class irisdict(dict):
    def __init__(self, *args, **kw):
        super(irisdict,self).__init__(*args, **kw)
        self.itemlist = super(irisdict,self).keys()
         
        # Open a connection to the server
        args = {'hostname':'127.0.0.1',
                'port':51773,
                'namespace':'USER',
                'username':'_SYSTEM',
                'password':'SYS'}
        conn = irisnative.createConnection(**args)
        self.iris = irisnative.createIris(conn)

    def __setitem__(self, key, value):
        self.iris.set(value, key)
        super(irisdict,self).__setitem__(key, value)

    def __getitem__(self, key):
        return self.iris.getBytes(key)
        
    def __contains__(self, key):
        return self.iris.isDefined(key)
        
    def __delitem__(self, key):
        return self.iris.kill(key) == b'OK'
        