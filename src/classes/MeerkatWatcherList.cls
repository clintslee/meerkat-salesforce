/**
 *  A list resource for Watchers.
 *
**/
public with sharing class MeerkatWatcherList extends MeerkatResource.ListResource 
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatWatcherList(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.RESOURCES_ENDPOINT + '/broadcasts/' + this.getRequestParentId() + '/watchers';
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
		return new MeerkatWatcher(client, params);
	}

	/**
	 *  @return the json field name for parsing this array.
	 *
	**/
	public override String getListKey()
	{
		return 'watchers';
	}

	/**
	 *  @return the json field name for parsing this result.
	 *
	**/
	public override String getResultKey()
	{
		return 'result';
	}

	/**
	 *  @return a list of MeerkatWatchers
	 *
	 *  Loop through the page result objects and make new
	 *  MeerkatWatcher objects.  This method will make a
	 *  callout to the Meerkat API.
	 *
	**/
	public List<MeerkatWatcher> getPageData()
	{
		List<MeerkatWatcher> returnList = new List<MeerkatWatcher>();

		for(Object o : this.getObjectPageData())
		{
			if(o instanceof MeerkatWatcher) {
				returnList.add((MeerkatWatcher) o);
			}
		}
		return returnList;
	}
}