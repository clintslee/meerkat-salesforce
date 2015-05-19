/**
 *  A Restream contains details about a restream on a broadcast.
 *
**/
public with sharing class MeerkatRestream extends MeerkatResource.InstanceResource
{
	/**
	 *  @param client
	 *         a REST client
	 *
	 *  Construct with a REST client.
	 *
	**/
	public MeerkatRestream(MeerkatRestClient client) 
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
	public MeerkatRestream(MeerkatRestClient client, Map<String,Object> properties)
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
	 *  Getter for the watcher (person who made the comment)
	 *
	**/
	public MeerkatWatcher getWatcher()
	{
		Map<String,Object> props = (Map<String,Object>) this.getObject('watcher');
		return new MeerkatWatcher(this.getClient(),props);
	}

	/**
	 *  Getter for the title.
	 *  
	**/
	public String getTitle()
	{
		return this.getProperty('title');
	}

	/**
	 *  Getter for the message (comment)
	 *
	**/
	public String getMessage()
	{
		return this.getProperty('message');
	}
}