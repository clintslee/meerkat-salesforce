/**
 *  API for interacting with an HttpResponse.
 *
**/
public with sharing class MeerkatRestResponse 
{
	private String responseBody;
	private Integer responseStatus;
	private String url;
	private String queryString;
	private String contentType;
	private Boolean error;
	private String resultKey;

	/**
	 *  @param endpoint
	 *         the URL endpoint
	 *
	 *  @param responseBody
	 *         the body of the response
	 *
	 *  @param status
	 *         the HTTP status code
	 *
	 *  Constructor
	 *
	**/
	public MeerkatRestResponse(String endpoint, String responseBody, Integer status) 
	{
		Pattern p = Pattern.compile('([^?]+)\\??(.*)');
        Matcher m = p.matcher(endpoint);
        m.matches();

        this.url = m.group(1);
        this.queryString = m.group(2);
        this.responseBody = responseBody;
        this.responseStatus = status;
        this.error = (status >= 400);
	}

	/**
	 *  Getter for the response body.
	 *
	**/
	public String getResponseBody()
	{
		return responseBody;
	}

	/**
	 *  Getter for the response status.
	 *
	**/
	public Integer getResponseStatus()
	{
		return responseStatus;
	}

	/**
	 *  Getter for the endpoint url.
	 *
	**/
	public String getUrl()
	{
		return url;
	}

	/**
	 *  Getter for the query string parameters.
	 *
	**/
	public String getQueryString()
	{
		return queryString;
	}

	/**
	 *  Getter for the result key.
	 *
	**/
	public String getResultKey()
	{
		return this.resultKey;
	}

	/**
	 *  Setter for the response body.
	 *
	**/
	public void setResultKey(String resultKey)
	{
		this.resultKey = resultKey;
	}

	/**
	 *  Getter for the error.
	 *
	**/
	public Boolean isError()
	{
		return error;
	}

	/**
	 *  Error is below 500.
	 *
	**/
	public Boolean isClientError()
	{
		return (responseStatus >= 400 && responseStatus < 500);
	}

	/**
	 *  Error is 500 or above.
	 *
	**/
	public Boolean isServerError()
	{
		return responseStatus >= 500;
	}

	/**
	 *  Setter for the response body.
	 *
	**/
	public void setContentType(String contentType)
	{
		this.contentType = contentType;
	}

	/**
	 *  @return a map of the json response
	 *
	**/
	public Map<String,Object> toMap()
	{
		Map<String,Object> prop = new Map<String,Object>();
		Map<String,Object> m = MeerkatParser.jsonToMap(responseBody);
		
		if(this.getResultKey() != null && (m.get(this.getResultKey()) instanceof Map<String,Object>)) {
            prop = (Map<String,Object>) m.get(this.getResultKey());
		} else {
		    prop = m;
		}
		return prop;
	}
}