require 'functional'
local lu = require('luaunit')

Test = {}
	function Test:setUp()
		self.t = setmetatable({ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }, {__index = table})
	end

	function Test:test_where()
		local r = self.t:where('x -> x >= 5')
		lu.assertNotNil(r)
		lu.assertEquals(r, { 5, 6, 7, 8, 9, 10 })

		r = self.t:where 'x -> x + 2 == 5'
		lu.assertNotNil(r)
		lu.assertEquals(r, { 3 })

		r = self.t:where 'x -> x % 2 ~= 0'
		lu.assertNotNil(r)
		lu.assertEquals(r, { 1, 3, 5, 7, 9 })

		local r = self.t:where('x -> valid(x)', { valid = function(X) return x % 2 == 0 and x or nil end })
		lu.assertEquals(r, { 2, 4, 6, 8, 10 })
	end

	function Test:test_map()
		local r = self.t:map 'x -> x'
		lu.assertEquals(r, { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 })

		r = self.t:map 'x -> x + 2'
		lu.assertEquals(r, { 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 })

		r = self.t:map 'x -> x % 2'
		lu.assertEquals(r, { 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 })

		r = self.t:map('x -> incr(x)', { incr = function(x) return x + 1 end })
		lu.assertEquals(r, { 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 })
	end

os.exit(lu.LuaUnit.run())