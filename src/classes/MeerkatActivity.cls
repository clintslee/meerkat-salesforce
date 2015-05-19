/**
 *  A Broadcast Activity can be a like, comment, or restream activity
 *  that was created on a broadcast.  
 *
**/
public with sharing class MeerkatActivity extends MeerkatResource.InstanceResource
{
	/**
	 *  @param client
	 *         a MeerkatRestClient
	 *
	 *  Construct with a Rest Client.
	 *
	**/
	public MeerkatActivity(MeerkatRestClient client) 
	{
		super(client);
	}

	/**
	 *  @param client
	 *         a MeerkatRestClient
	 *  @param properties
	 *         a Map of properties
	 *
	 *  Construct with a Rest Client and properties.
	 *
	**/
	public MeerkatActivity(MeerkatRestClient client, Map<String,Object> properties)
	{
		super(client, properties);
	}

	/**
	 *  @return the URL location for this resource.
	 *
	 *  An activity is not accessed directly so no resource location is needed.
	 *
	**/ 
	public override String getResourceLocation()
	{
		return '';
	}

	/**
	 *  @return the json field name needed to parse the result.
	 *
	**/
	public override String getResultKey()
	{
		return null;
	}

	/**
	 *  @return the watcher object for the person who created this activity.
	 *
	 *  Get the Activity's Watcher.
	 *
	**/
	public MeerkatWatcher getWatcher()
	{
		Map<String,Object> props = (Map<String,Object>) this.getObject('watcher');
		return new MeerkatWatcher(this.getClient(),props);
	}

	/**
	 *  @return the title of the activity.
	 *
	**/
	public String getTitle()
	{
		return this.getProperty('title');
	}

	/**
	 *  @return the message of the activity.
	 *
	**/
	public String getMessage()
	{
		return this.getProperty('message');
	}
}