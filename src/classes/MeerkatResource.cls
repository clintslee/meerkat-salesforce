public abstract with sharing class MeerkatResource 
{
	private MeerkatRestClient client;
	private Boolean loaded;
	private String requestParentId;

	public MeerkatResource(MeerkatRestClient client) 
	{
		this.client = client;
		this.loaded = false;
	}

	public MeerkatRestClient getClient()
	{
		return client;
	}

	protected void load(Map<String,Object> params)
	{
		String path = getResourceLocation();
		MeerkatRestResponse res = getClient().safeRequest(path,'GET',params);

		parseResponse(res);
		this.loaded = true;
	}

	public void setRequestParentId(String id)
	{
		this.requestParentId = id;
	}

	public String getRequestParentId()
	{
		return this.requestParentId;
	}

	protected Boolean isLoaded()
	{
		return loaded;
	}

	protected void setLoaded(Boolean loaded)
	{
		this.loaded = loaded;
	}

	protected abstract String getResourceLocation();

	protected abstract void parseResponse(MeerkatRestResponse res);

	/**
	 *  Instance Resource
	 *
	**/
	public abstract class InstanceResource extends MeerkatResource
	{
		private Map<String,Object> properties;

		public InstanceResource(MeerkatRestClient client)
		{
			super(client);
            this.properties = new Map<String,Object>();
		}

		public InstanceResource(MeerkatRestClient client, Map<String,Object> properties)
		{
			super(client);
			this.properties = properties;
			this.setLoaded(true);
		}

		public String getProperty(String name)
		{
			Object p = properties.get(name);

			if(p == null && !this.isLoaded()) {
				this.load(new Map<String,Object>());
			}

			p = properties.get(name);

			if(p == null) {
				return null;
			}

			if(p instanceof String) {
				return (String)p;
			}

			throw new MeerkatRestException('Property ' + name + 'is an object. Use getObject() instead.');
		}

		public Double getPropertyDecimal(String name)
		{
			Object p = properties.get(name);

			if(p == null) {
				return null;
			}
			return Decimal.valueOf((String)p);
		}

		public Integer getPropertyInteger(String name)
		{
			Object p = properties.get(name);

			if(p == null) {
				return null;
			}
			return Integer.valueOf(p);
		}

		public DateTime getPropertyDateTime(String name)
		{
			Long t = Long.valueOf((String)properties.get(name));
			return DateTime.newInstance(t);
		}

		protected Object getObject(String name) 
		{
            Object p = properties.get(name);

            if(p == null && !this.isLoaded()) {
				this.load(new Map<String,Object>());
			}

			p = properties.get(name);
    
            if (p == null) {
                throw new MeerkatRestException('Property ' + name + ' does not exist.');
            }

            return p;
        }

        protected List<String> getStringList(String name) 
        {
            List<String> s = new List<String>();
            for(Object o : (List<Object>)this.getObject(name)) {
                s.add(String.valueof(o));
            } 
            return s;
        }

		protected override void parseResponse(MeerkatRestResponse res)
		{
			res.setResultKey(this.getResultKey());
			this.properties = res.toMap();
		}

		protected abstract String getResultKey();
	}

	/**
	 *  List Resource
	 *
	**/
	public abstract class ListResource extends MeerkatResource 
	{
		public List<Object> pageData;

		public ListResource(MeerkatRestClient client)
		{
			super(client);
		}

		protected override void parseResponse(MeerkatRestResponse res) 
		{
			this.pageData = this.toList(res);
		}
			
		protected List<Object> toList(MeerkatRestResponse res)
		{
			List<Object> returnList = new List<Object>();

			res.setResultKey(this.getResultKey());
			Map<String,Object> m = res.toMap();

			if(m.get(this.getListKey()) instanceof List<Object>) {
				List<Object> objs = (List<Object>) m.get(this.getListKey());

				for(Object o : objs)
				{
					if(o instanceof Map<String,Object>) {
						Object instance = this.makeNew(this.getClient(), (Map<String,Object>) o);
						returnList.add(instance);
					}
				}
			}
			return returnList;
		}

		public List<Object> getObjectPageData()
		{
			if(!this.isLoaded()) {
				this.load(new Map<String,Object>());
			}
			return this.pageData;
		}

		protected abstract String getListKey();

		protected abstract String getResultKey();

		protected abstract Object makeNew(MeerkatRestClient client, Map<String,Object> params);
	}
}