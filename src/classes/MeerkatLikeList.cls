/**
 *  A list resource for Likes.
 *
 *
**/
public with sharing class MeerkatLikeList extends MeerkatResource.ListResource 
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatLikeList(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.CHANNELS_ENDPOINT + '/broadcasts/' + this.getRequestParentId() + '/likes';
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
		return new MeerkatLike(client, params);
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
	 *  @return a list of MeerkatLikes
	 *
	 *  Loop through the page result objects and make new
	 *  MeerkatLike objects.  This method will make a
	 *  callout to the Meerkat API.
	 *
	**/
	public List<MeerkatLike> getPageData()
	{
		List<MeerkatLike> returnList = new List<MeerkatLike>();

		for(Object o : this.getObjectPageData())
		{
			if(o instanceof MeerkatLike) {
				returnList.add((MeerkatLike) o);
			}
		}
		return returnList;
	}
}