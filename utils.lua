-- (no subclassing)
function class(prototype, constructor)
	if constructor ~= nil then
		prototype.new = constructor
	end
	local mt = getmetatable(prototype)
	if mt == nil then
		mt = setmetatable(prototype, {})
	else
		assert(mt.__call == nil)
	end
	mt.__call = function(cls, ...)
		local instance = setmetatable({}, {__index = cls})
		instance.class = cls
		if cls.new ~= nil then
			cls.new(instance, ...)
		end
		return instance
	end
	return setmetatable(prototype, mt)
end
