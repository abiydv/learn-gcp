def http(request):
    """Responds to any HTTP request.
    Args:
        request (flask.Request): HTTP request object.
    Returns:
        The response text or any set of values that can be turned into a
        Response object using
        `make_response <http://flask.pocoo.org/docs/1.0/api/#flask.Flask.make_response>`.
    """

    try:
        entity = request.args['name']
    except Exception as e:
        print("exception {}".format(e))
        entity = "world"

    return "Hello {}!".format(entity.capitalize())

