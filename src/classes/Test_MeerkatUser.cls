@istest
public with sharing class Test_MeerkatUser 
{
	private static String response = '{\"result\":{\"info\":{\"id\":\"123\"},' +
	                                 '\"stats\":{\"followingCount\":10},' +
	                                 '\"followupActions\":{\"follow\":\"https://static.meerkatapp.co\"} }}'; 

	private static String followResponse = '{\"result\":[{\"displayName\":\"meer\",\"username\":\"meer\",' + 
	                                       '\"score\":1000}]}';

	static testmethod void testOne()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatUser u = client.getUser('123');

		System.assertEquals('123',(String)u.getInfo().get('id'));
		System.assertEquals(10, Integer.valueOf(u.getStats().get('followingCount')));
		System.assertEquals('https://static.meerkatapp.co',(String)u.getFollowupActions().get('follow'));
		Test.stopTest();
	}

	static testmethod void testTwo()
	{
		MeerkatUser user = new MeerkatUser(MeerkatAPI.getDefaultClient());
	}

	static testmethod void testThree()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',followResponse,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatUser u = client.getUser('123');
		MeerkatFollowerList followers = u.getFollowers();
		System.assertEquals(1,followers.getPageData().size());

		for(MeerkatUser follower : followers.getPageData())
		{
			System.assertEquals('meer',follower.getDisplayName());
			System.assertEQuals('meer',follower.getUsername());
			System.assertEquals(1000,follower.getScore());
		}
		Test.stopTest();
	}

	static testmethod void testFour()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',followResponse,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatUser u = client.getUser('123');
		MeerkatFollowingList following = u.getFollowing();
		System.assertEquals(1,following.getPageData().size());

		for(MeerkatUser f : following.getPageData())
		{
			System.assertEquals('meer',f.getDisplayName());
			System.assertEQuals('meer',f.getUsername());
			System.assertEquals(1000,f.getScore());
		}
		Test.stopTest();
	}

	static testmethod void setupData()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		config.API_Key__c = '112358';
		upsert config;
	}
}