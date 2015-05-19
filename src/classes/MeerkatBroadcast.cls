/**
 *  A Broadcast represents a live-stream.  This is one of the main
 *  resources of the Meerkat API.
 *
**/
public with sharing class MeerkatBroadcast extends MeerkatResource.InstanceResource
{
	/**
	 *  @param client
	 *         a Rest Client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatBroadcast(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @param client
	 *         a Rest Client
	 *  @param properties
	 *         a map of properties
	 *
	 *  Construct with a REST client and a map of properties.
	 *
	**/
	public MeerkatBroadcast(MeerkatRestClient client, Map<String,Object> properties)
	{
		super(client,properties);
	}

	/**
	 *  @param client
	 *         a Rest Client
	 *  @param id
	 *         the id of a Broadcast
	 *
	 *  Construct with a REST client and a Broadcast id.
	 *
	**/
	public MeerkatBroadcast(MeerkatRestClient client, String id)
	{
		this(client, new Map<String,Object>{'id' => id});
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.RESOURCES_ENDPOINT + '/broadcasts/' + this.getId() + '/summary';
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
	 *  Getter for the Broadcast id.
	 *
	**/
	public String getId()
	{
		return this.getProperty('id');
	}

	/**
	 *  Getter for the Broadcast URL.
	 *
	**/
	public String getUrl()
	{
		return this.getProperty('broadcast');
	}

	/**
	 *  Getter for the Broadcast start time.
	 *
	**/
	public DateTime getStartTime()
	{
		return this.getPropertyDateTime('startTime');
	}

	/**
	 *  Getter for a list of Broadcast influencers.
	 *
	**/
	public List<String> getInfluencers()
	{
		return this.getStringList('influencers');
	}

	/** SUB-RESOURCE METHODS **/

	/**
	 *  Getter for the Broadcast Summary.
	 *
	**/
	public MeerkatBroadcastSummary getSummary()
	{
		MeerkatBroadcastSummary summary = new MeerkatBroadcastSummary(this.getClient());
		summary.setRequestParentId(this.getId());
		return summary;
	}

	/**
	 *  Getter for the Broadcast activities.
	 *
	**/
	public MeerkatActivityList getActivities()
	{
		MeerkatActivityList activities = new MeerkatActivityList(this.getClient());
		activities.setRequestParentId(this.getId());
		return activities;
	}

	/**
	 *  Getter for the Broadcast restreams.
	 *
	**/
	public MeerkatRestreamList getRestreams()
	{
		MeerkatRestreamList restreams = new MeerkatRestreamList(this.getClient());
		restreams.setRequestParentId(this.getId());
		return restreams;
	}

	/**
	 *  Getter for the Broadcast comments.
	 *
	**/
	public MeerkatCommentList getComments()
	{
		MeerkatCommentList comments = new MeerkatCommentList(this.getClient());
		comments.setRequestParentId(this.getId());
		return comments;
	}

	/**
	 *  Getter for the Broadcast likes.
	 *
	**/
	public MeerkatLikeList getLikes()
	{
		MeerkatLikeList likes = new MeerkatLikeList(this.getClient());
		likes.setRequestParentId(this.getId());
		return likes;
	}

	/**
	 *  Getter for the Broadcast watchers.
	 *
	**/
	public MeerkatWatcherList getWatchers()
	{
		MeerkatWatcherList watchers = new MeerkatWatcherList(this.getClient());
		watchers.setRequestParentId(this.getId());
		return watchers;
	}
}