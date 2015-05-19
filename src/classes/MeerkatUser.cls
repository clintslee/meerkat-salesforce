/**
 *  A User represents a Meerkat user.  This is one of the main
 *  resources of the Meerkat API.
 *
**/
public with sharing class MeerkatUser extends MeerkatResource.InstanceResource 
{
	/**
	 *  @param client
	 *         a Rest Client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatUser(MeerkatRestClient client) 
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
	public MeerkatUser(MeerkatRestClient client, Map<String,Object> properties)
	{
		super(client,properties);
	}

	/**
	 *  @param client
	 *         a Rest Client
	 *  @param id
	 *         the id of a Broadcast
	 *
	 *  Construct with a REST client and a User id.
	 *
	**/
	public MeerkatUser(MeerkatRestClient client, String id)
	{
		this(client, new Map<String,Object>{'id' => id});
		this.setLoaded(false);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return MeerkatRestClient.RESOURCES_ENDPOINT + '/users/' + this.getId() + '/profile';
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
	 *  Getter for the id.
	 *
	**/
	public String getId()
	{
		return this.getProperty('id');
	}

	/**
	 *  Getter for the display name.
	 *
	**/
	public String getDisplayName()
	{
		return this.getProperty('displayName');
	}

	/**
	 *  Getter for the username.
	 *
	**/
	public String getUsername()
	{
		return this.getProperty('username');
	}

	/**
	 *  Getter for the score.
	 *
	**/
	public Integer getScore()
	{
		return this.getPropertyInteger('score');
	}

	/**
	 *  Getter for the info object.
	 *
	**/
	public Map<String,Object> getInfo()
	{
		return ((Map<String,Object>) this.getObject('info'));
	}

	/**
	 *  Getter for the stats object.
	 *
	**/
	public Map<String,Object> getStats()
	{
		return ((Map<String,Object>) this.getObject('stats'));
	}

	/**
	 *  Getter for the followup actions object.
	 *
	**/
	public Map<String,Object> getFollowupActions()
	{
		return ((Map<String,Object>) this.getObject('followupActions'));
	}

	/**
	 *  Getter for the followers.
	 *
	**/
	public MeerkatFollowerList getFollowers()
	{
		MeerkatFollowerList followers = new MeerkatFollowerList(this.getClient());
		followers.setRequestParentId(this.getId());
		return followers;
	}

	/**
	 *  Getter for the following.
	 *
	**/
	public MeerkatFollowingList getFollowing()
	{
		MeerkatFollowingList following = new MeerkatFollowingList(this.getClient());
		following.setRequestParentId(this.getId());
		return following;
	}
}