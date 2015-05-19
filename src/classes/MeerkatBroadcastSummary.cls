/**
 *  A Broadcast Summary contains details about a Broadcast.
 *
**/
public with sharing class MeerkatBroadcastSummary extends MeerkatResource.InstanceResource
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatBroadcastSummary(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.RESOURCES_ENDPOINT + '/broadcasts/' + this.getRequestParentId() + '/summary';
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
	 *  Getter for the Id
	 *
	**/
	public String getId()
	{
		return this.getProperty('id');
	}

	/**
	 *  Getter for the Cover
	 *
	**/
	public String getCover()
	{
		return this.getProperty('cover');
	}

	/**
	 *  Getter for the broadcaster
	 *
	**/
	public Map<String,Object> getBroadcaster()
	{
		return (Map<String,Object>) this.getObject('broadcaster');
	}

	/**
	 *  Getter for the caption
	 *
	**/
	public String getCaption()
	{
		return this.getProperty('caption');
	}

	/**
	 *  Getter for the location
	 *
	**/
	public String getLocation()
	{
		return this.getProperty('location');
	}

	/**
	 *  Getter for the place
	 *
	**/
	public String getPlace()
	{
		return this.getProperty('place');
	}

	/**
	 *  Getter for the watchers count
	 *
	**/
	public Integer getWatchersCount()
	{
		return this.getPropertyInteger('watchersCount');
	}

	/**
	 *  Getter for the comments count
	 *
	**/
	public Integer getCommentsCount()
	{
		return this.getPropertyInteger('commentsCount');
	}

	/**
	 *  Getter for the likes count
	 *
	**/
	public Integer getLikesCount()
	{
		return this.getPropertyInteger('likesCount');
	}

	/**
	 *  Getter for the restreams count
	 *
	**/
	public Integer getRestreamsCount()
	{
		return this.getPropertyInteger('restreamsCount');
	}

	/**
	 *  Getter for the status
	 *
	**/
	public String getStatus()
	{
		return this.getProperty('status');
	}

	/**
	 *  Getter for the end time
	 *
	**/
	public DateTime getEndTime()
	{
		return this.getPropertyDateTime('endTime');
	}

	/**
	 *  Getter for the tweet id
	 *
	**/
	public String getTweetId()
	{
		return this.getProperty('tweetId');
	}

	/**
	 *  Getter for the tags
	 *
	**/
	public List<String> getTags()
	{
		return this.getStringList('tags');
	}

	/**
	 *  Getter for the influencers
	 *
	**/
	public List<String> getInfluencers()
	{
		return this.getStringList('influencers');
	}
}