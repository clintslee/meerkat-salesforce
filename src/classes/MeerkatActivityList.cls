/**
 *  A list resource for Activities.
 *
**/
public with sharing class MeerkatActivityList extends MeerkatResource.ListResource
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatActivityList(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.RESOURCES_ENDPOINT + '/broadcasts/' + this.getRequestParentId() + '/activities';
	}

	/**
	 *  @param client
	 *         a REST client
	 *  @param params
	 *         a map of properties
	 *
	 *  Create a new MeerkatActivity object.
	 *
	**/
	public override Object makeNew(MeerkatRestClient client, Map<String,Object> params)
	{
		return new MeerkatActivity(client, params);
	}

	/**
	 *  @return the json field name for parsing this array.
	 *
	**/
	public override String getListKey()
	{
		return 'activities';
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
	 *  @return a list of MeerkatActivities
	 *
	 *  Loop through the page result objects and make new
	 *  MeerkatActivity objects.  This method will make a
	 *  callout to the Meerkat API.
	 *
	**/
	public List<MeerkatActivity> getPageData()
	{
		List<MeerkatActivity> returnList = new List<MeerkatActivity>();

		for(Object o : this.getObjectPageData())
		{
			if(o instanceof MeerkatActivity) {
				returnList.add((MeerkatActivity) o);
			}
		}
		return returnList;
	}
}