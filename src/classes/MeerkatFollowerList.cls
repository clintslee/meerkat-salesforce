/**
 *  A list resource for followers (users who follow a given user)
 *
**/
public with sharing class MeerkatFollowerList extends MeerkatResource.ListResource
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatFollowerList(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.SOCIAL_ENDPOINT + '/users/' + this.getRequestParentId() + '/followers';
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
		return new MeerkatUser(client, params);
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
	 *  @return a list of MeerkatUsers
	 *
	 *  Loop through the page result objects and make new
	 *  MeerkatUser objects.  This method will make a
	 *  callout to the Meerkat API.
	 *
	**/
	public List<MeerkatUser> getPageData()
	{
		List<MeerkatUser> returnList = new List<MeerkatUser>();

		for(Object o : this.getObjectPageData())
		{
			if(o instanceof MeerkatUser) {
				returnList.add((MeerkatUser) o);
			}
		}
		return returnList;
	}
}