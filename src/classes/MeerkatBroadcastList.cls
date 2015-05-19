/**
 *  A list resource object for Broadcasts. 
 *
**/
public with sharing class MeerkatBroadcastList extends MeerkatResource.ListResource
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatBroadcastList(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return '/broadcasts';
	}

	/**
	 *  @param client
	 *         a REST client
	 *  @param params
	 *         a map of properties
	 *
	 *  Create a new MeerkatBroadcast object.
	 *
	**/
	public override Object makeNew(MeerkatRestClient client, Map<String,Object> params)
	{
		return new MeerkatBroadcast(client, params);
	}

	/**
	 *  @return the json field name for parsing this array.
	 *
	**/
	public override String getListKey()
	{
		return 'result';
	}

	/**
	 *  @return the json field name for parsing this result.
	 *
	**/
	public override String getResultKey()
	{
		return null;
	}

	/**
	 *  @return a list of MeerkatBroadcasts
	 *
	 *  Loop through the page result objects and make new
	 *  MeerkatBroadcast objects.  This method will make a
	 *  callout to the Meerkat API.
	 *
	**/
	public List<MeerkatBroadcast> getPageData()
	{
		List<MeerkatBroadcast> returnList = new List<MeerkatBroadcast>();

		for(Object o : this.getObjectPageData())
		{
			if(o instanceof MeerkatBroadcast) {
				returnList.add((MeerkatBroadcast) o);
			}
		}
		return returnList;
	}
}