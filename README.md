# Short-url-app
RoR application that runs in docker. Exposes an API that provides a url shortening service. Data is stored in a postgres db. 

### Build instructions
1. docker-compose build
2. docker-compose run short-app rails db:setup && rails db:migrate

### API Spec
#### Reference:
| Endpoint     | Functionality | 
|:-------------|:-------------:|
| POST /shortcodes | Add URL to entry and generate shortcode |
| GET /:short_url | Redirect to original url |
| GET /top100 | List top 100 most popular urls |

#### Curl Examples
* curl -XPOST -d "original_url=https://google.com" http://localhost:3000/shortcodes
* curl -XGET http://localhost:3000/:short_url
* curl -XGET http://localhost:3000/top100

### Algorithm
Goal was to make the url as short as possible. Started out with the length of the original url... which doesn't work because you could end up with a very large "shortcode". Ended up using length of original * a random number between 128 and 254 -- the reason for this is because it sets up later to use x/62 and can get at least 4 characters with it should your length be 1. Used a char map which is 62 chars in length and mod that with x to give a character value. Update the model's current :short_url and "return".

```
def get_short_url
    @shortcode = ""
    x = self[:original_url].length * rand(128...254)
    while x > 0
        @shortcode = @shortcode + CHAR_MAP[x%62]
        x = x/62
    end
    self[:short_url] = @shortcode
end
```