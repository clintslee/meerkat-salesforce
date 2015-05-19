/**
 * Mock Http Requests for testing.
 *
 *
**/
@istest
public with sharing class MeerkatHTTPMock implements HttpCalloutMock
{
	protected Integer code;
	protected String status;
	protected String method;
	protected String bodyAsString;
	protected Blob bodyAsBlob;
	protected Map<String,String> responseHeaders;
	
	/**
	 *  Constructor
	 *
	**/
	public MeerkatHTTPMock(Integer code, String status, String body, Map<String,String> responseHeaders)
	{
		this.code = code;
		this.status = status;
		method = null;
		this.bodyAsString = body;
		this.bodyAsBlob = null;
		this.responseHeaders = responseHeaders;
	}

    /**
     *  Setter for the method.
     *
    **/
    public void setMethod(String method)
    {
    	this.method = method;
    }

    /**
     *  Getter for the method.
     *
    **/
    public String getMethod()
    {
    	return method;
    }

	/** 
	 *  @param  request - an HttpRequest
	 *  @return an HttpResponse
	 *
	 *  Return a mocked HttpResponse.
	 *
	**/
	public HttpResponse respond(HttpRequest request)
	{
		HttpResponse response = new HttpResponse();
		response.setStatusCode(code);
		response.setStatus(status);
		
		if(bodyAsBlob != null)
		   response.setBodyAsBlob(bodyAsBlob);
		else 
		   response.setBody(bodyAsString);
		
		if(responseHeaders != null) {
		   for(String key : responseHeaders.keySet()) 
		   {
		   	   response.setHeader(key, responseHeaders.get(key)); 
		   }	
		}
		return response;
	}
}