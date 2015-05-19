/**
 *  A list resource for Comments.
 *
**/
public with sharing class MeerkatCommentList extends MeerkatResource.ListResource 
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatCommentList(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.CHANNELS_ENDPOINT + '/broadcasts/' + this.getRequestParentId() + '/comments';
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
		return new MeerkatComment(client, params);
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
	 *  @return a list of MeerkatComments
	 *
	 *  Loop through the page result objects and make new
	 *  MeerkatComment objects.  This method will make a
	 *  callout to the Meerkat API.
	 *
	**/
	public List<MeerkatComment> getPageData()
	{
		List<MeerkatComment> returnList = new List<MeerkatComment>();

		for(Object o : this.getObjectPageData())
		{
			if(o instanceof MeerkatComment) {
				returnList.add((MeerkatComment) o);
			}
		}
		return returnList;
	}
}