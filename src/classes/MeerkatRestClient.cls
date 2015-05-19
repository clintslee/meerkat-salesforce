/**
 *  The REST client provides an interface to make requests to the Meerkat API.
 *
 *
**/
public with sharing class MeerkatRestClient 
{
	/** Current VERSION **/
	private static final String API_VERSION = '1.0';

	/** Resources Endpoint **/
	public static final String RESOURCES_ENDPOINT = 'https://resources.meerkatapp.co';

	/** Channels Endpoint **/
	public static final String CHANNELS_ENDPOINT = 'https://channels.meerkatapp.co';

	/** Social Endpoint **/
	public static final String SOCIAL_ENDPOINT = 'https://social-cdn.meerkatapp.co';

	/** The API Key **/
	private String apiKey;

	/** The number of retries **/
	private Integer numRetries = 3;


	/**
	 *  Construct a MeerkatRestClient with the given API Key.
	 *  
	 *  @param apiKey
	 *             the api key provided by Meerkat.
	 *
	**/
	public MeerkatRestClient(String apiKey) 
	{
	    this.apiKey = apiKey;	
	}

	/**
	 *  @param numRetries
	 *         the number of retries to make
	 *
	**/
	public void setNumRetries(Integer numRetries)
	{
		this.numRetries = numRetries;
	}

	/**
	 *  @return the number of retries
	 *
	**/
	public Integer getNumRetries()
	{
		return numRetries;
	}

	/**
	 *  @param method
	 *         the HTTP method
	 *
	 *	@param path
	 *	       the URL path
	 *
	 *	@param params
	 *         a map of request parameters
	 *
	 *
	**/
	private HttpRequest buildMethod(String method, String path, Map<String,Object> params)
	{
		String m = method.toLowerCase();

		if(m.equals('get'))
		   return buildGetRequest(path,params);
		else if(m.equals('post'))
		   return buildPostRequest(path,params);
		else if(m.equals('put'))
		   return buildPutRequest(path,params);
		else if(m.equals('delete'))
		   return buildDeleteRequest(path,params);
		else
		   throw new MeerkatRestException('Unknown method: ' + method);
	}

	/**
	 *  @param path
	 *         the URL path
	 *
	 *	@param params
	 *         a map of request parameters
	 *
	 *  @return a fully constructed GET request.
	 *
	**/
	private HttpRequest buildGetRequest(String path, Map<String,Object> params)
	{
		URL uri = buildUri(path,params);

		HttpRequest req = new HttpRequest();
		req.setEndpoint(uri.toExternalForm());
		req.setMethod('GET');
		return req;
	}

	/**
	 *  @param path
	 *         the URL path
	 *
	 *	@param params
	 *         a map of request parameters
	 *
	 *  @return a fully constructed POST request.
	 *
	**/
	private HttpRequest buildPostRequest(String path, Map<String,Object> params)
	{
		URL uri = buildUri(path);
		String body = buildBody(params);

		HttpRequest req = new HttpRequest();
		req.setEndpoint(uri.toExternalForm());
		req.setBody(body);
		req.setMethod('POST');
		return req;
	}

	/**
	 *  @param path
	 *         the URL path
	 *
	 *	@param params
	 *         a map of request parameters
	 *
	 *  @return a fully constructed PUT request.
	 *
	**/
	private HttpRequest buildPutRequest(String path, Map<String,Object> params)
	{
		URL uri = buildUri(path);
		String body = buildBody(params);

		HttpRequest req = new HttpRequest();
		req.setEndpoint(uri.toExternalForm());
		req.setBody(body);
		req.setMethod('PUT');
		return req;
	}

	/**
	 *  @param path
	 *         the URL path
	 *
	 *	@param params
	 *         a map of request parameters
	 *
	 *  @return a fully constructed DELETE request.
	 *
	**/
	private HttpRequest buildDeleteRequest(String path, Map<String,Object> params)
	{
		URL uri = buildUri(path);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('DELETE');
        return req;
	}

	/**
	 *  @param params
	 *         a map of request parameters
	 *
	 *  @return a String body with the given parameters
	 *
	**/
	private String buildBody(Map<String,Object> params)
	{
		String body = '';
		if(params != null) {
			for(String key : params.keySet())
			{
				try {
			        body += (body == '' ? '' : '&') + 
				    key + '=' + 
				    EncodingUtil.urlEncode((String)params.get(key),'UTF-8');
				} catch(Exception e) {
					System.debug(logginglevel.WARN, 'Error building body: ' + key + '=' + params.get(key) + ' : ' + e);
				}
			}
		}
		return body;
	}

	/**
	 *  @param path
	 *         the URL path
	 *  
	 *  @param params
	 *         a map of request parameters
	 *
	 *  @return the fully constructed URL endpoint
	 *
	 *
	**/
	private URL buildUri(String path, Map<String,Object> params)
	{
		String temp = (path + '?v=' + API_VERSION);

		if(params != null && params.size() > 0) {
			temp += ('&' + buildBody(params));
		}

		URL uri;
		try {
			uri = new URL(temp);
		} catch(Exception e) {
			throw new MeerkatRestException('Bad URI: ' + temp, e);
		}
		return uri;
	}

	/**
	 *  @param path
	 *         the URL path
	 *
	 *  @return the fully constructed URL endpoint
	 *
	**/
	private URL buildUri(String path)
	{
		return buildUri(path, new Map<String,Object>());
	}

	/**
	 *  @param path
	 *         a URL path
	 *
	 *  @param method
	 *         an HTTP method
	 *
	 *  @param params 
	 *         a map of request parameters
	 *
	 *  @return a MeerkatRestResponse
	 * 
	 *  Build request and make API call.
	 *
	**/
	public MeerkatRestResponse request(String path, String method, Map<String,Object> params)
	{
		HttpRequest request = setupRequest(path,method,params);
		
		String responseBody;
		String contentType;
		Integer statusCode;

		HttpResponse res = new Http().send(request);
		responseBody = (res.getBody() == null ? '' : res.getBody());
		statusCode = res.getStatusCode();
		contentType = res.getHeader('Content-Type');

		MeerkatRestResponse restResponse = new MeerkatRestResponse(request.getEndpoint(),responseBody,statusCode);
		restResponse.setContentType(contentType);

		return restResponse;
	}

	/**
	 *  @param path
	 *         a URL path
	 *
	 *  @param method
	 *         an HTTP method
	 *
	 *  @param params 
	 *         a map of request parameters
	 *
	 *  @return an HttpRequest
	 * 
	 *  Build request but no API call is made.
	 *
	**/
	public HttpRequest setupRequest(String path, String method, Map<String,Object> params)
	{
		String lowerPath = path.toLowerCase();
		String temp = '';

		if(lowerPath.startsWith('http://') || lowerPath.startsWith('https://')) {
			temp += path;
		} else {
			temp += RESOURCES_ENDPOINT;

			if(!lowerPath.startsWith('/')) {
			   temp += '/';
			}

			temp += path;
		}

		path = temp;

		HttpRequest req = buildMethod(method,path,params);
		req.setHeader('Authorization', apiKey);

		return req;
	}

	/**
	 *  @param path
	 *         a URL path
	 *
	 *  @param method
	 *         an HTTP method
	 *
	 *  @param params 
	 *         a map of request parameters
	 *
	 *  @return a MeerkatRestResponse
	 * 
	 *  Build request and make API call.  The API call will be retried if a server error occurs.
	 *
	**/
	public MeerkatRestResponse safeRequest(String path, String method, Map<String,Object> params)
	{
		MeerkatRestResponse res = null;

		for(Integer i = 0; i < this.getNumRetries(); i++)
		{
			res = request(path,method,params);

			if(res.isClientError())
			   throw new MeerkatRestException(res.getResponseBody(),res.getResponseStatus());
			else if(res.isServerError()) {
				continue;
			}

			return res;
		}

		Integer errorCode = res == null ? -1 : res.getResponseStatus();
        throw new MeerkatRestException('Error connecting: ' + method + ' ' + path, errorCode);
	}

	/**
	 *  @return a MeerkatBroadcastList 
	 *
	 *  Lazy load a MeerkatBroadcastList
	 *
	**/
	public MeerkatBroadcastList getBroadcasts()
	{
		return new MeerkatBroadcastList(this);
	}

	/**
	 *  @return a MeerkatBroadcast 
	 *
	 *  Lazy load a MeerkatBroadcast
	 *
	**/
	public MeerkatBroadcast getBroadcast(String id)
	{
		return new MeerkatBroadcast(this,id);
	}

	/**
	 *  @return a MeerkatUser 
	 *
	 *  Lazy load a MeerkatUser
	 *
	**/
	public MeerkatUser getUser(String id)
	{
		return new MeerkatUser(this,id);
	}
}