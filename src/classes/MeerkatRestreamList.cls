/**
 *  A list resource for Restreams.
 *
**/
public with sharing class MeerkatRestreamList extends MeerkatResource.ListResource
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatRestreamList(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.CHANNELS_ENDPOINT + '/broadcasts/' + this.getRequestParentId() + '/restreams';
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
		return new MeerkatRestream(client, params);
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
	 *  @return a list of MeerkatRestreams
	 *
	 *  Loop through the page result objects and make new
	 *  MeerkatRestream objects.  This method will make a
	 *  callout to the Meerkat API.
	 *
	**/
	public List<MeerkatRestream> getPageData()
	{
		List<MeerkatRestream> returnList = new List<MeerkatRestream>();

		for(Object o : this.getObjectPageData())
		{
			if(o instanceof MeerkatRestream) {
				returnList.add((MeerkatRestream) o);
			}
		}
		return returnList;
	} 
}