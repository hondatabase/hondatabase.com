module Jekyll
	class ArticleRouteGenerator < Generator
	  safe true
  
	  def generate(site)
		site.posts.docs.each do |post|
		  if post.data['brands'] && post.data['models'] && post.data['generations'] && post.data['subcategory']
			generate_routes(site, post)
		  end
		end
	  end
  
	  def generate_routes(site, post)
		post.data['brands'].each do |brand|
		  post.data['generations'].each do |gen_hash|
			if gen_hash.key?(brand)
			  gen_hash[brand].each do |model, gens|
				gens.each do |gen|
				  route = "/#{brand}/#{model}/#{gen}/#{post.data['subcategory']}/#{post.data['slug']}.html"
				  site.pages << ArticlePage.new(site, site.source, route, post)
				end
			  end
			end
		  end
		end
	  end
	end
  
	class ArticlePage < Page
	  def initialize(site, base, dir, post)
		@site = site
		@base = base
		@dir  = File.dirname(dir)
		@name = File.basename(dir)
  
		self.process(@name)
		self.content = post.content
		self.data = post.data.dup
	  end
	end
  end