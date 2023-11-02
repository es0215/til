def hello_world(request):
    """HTTP Cloud Function.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text, or any set of values that can be turned into a
        Response object using `make_response`
        <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>.
    """
    return 'Hello, World!'
