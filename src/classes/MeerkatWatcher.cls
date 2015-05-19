/**
 *  A Watcher is someone who has watched and/or created an activity on a broadcast.
 *
**/
public with sharing class MeerkatWatcher extends MeerkatResource.InstanceResource 
{
	/**
	 *  @param client
	 *         a Rest Client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatWatcher(MeerkatRestClient client) 
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
	public MeerkatWatcher(MeerkatRestClient client, Map<String,Object> properties)
	{
		super(client,properties);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	**/
	public override String getResourceLocation()
	{
		return '';
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
	 *  Getter for the id.
	 *
	**/
	public String getId()
	{
		return this.getProperty('id');
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
	 *  Getter for the display name.
	 *
	**/
	public String getDisplayName()
	{
		return this.getProperty('displayName');
	}

	/**
	 *  Getter for the profile thumb image.
	 *
	**/
	public String getProfileThumbImage()
	{
		return this.getProperty('profileThumbImage');
	}

	/**
	 *  Getter for the follow.
	 *
	**/
	public String getFollow()
	{
		return this.getProperty('follow');
	}

	/**
	 *  Getter for the profile.
	 *
	**/
	public String getProfile()
	{
		return this.getProperty('profile');
	}

	/**
	 *  Getter for the photo url.
	 *
	**/
	public String getPhotoUrl()
	{
		return this.getProperty('photoUrl');
	}
}