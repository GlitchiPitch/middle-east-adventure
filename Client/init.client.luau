local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.Shared)

local Infrastructure = require(script.Infrastructure)
local Application = require(script.Application)
local Presentation = require(script.Presentation)

---@class Client
---@field shared Shared
---@field application ClientApplication
---@field presentation Presentation
---@field infrastructure ClientInfrastructure
---@field diContainer DIContainer
local Client = {}
Client.__index = Client

---@return Client
function Client.new()
    local self = setmetatable({}, Client)
    self.shared = Shared.new()
    self.diContainer = self.shared.diContainer
    self.application = Application.new(self.diContainer)
    self.presentation = Presentation.new()
    self.infrastructure = Infrastructure.new(self.diContainer)
    return self
end

function Client:init()
    self.diContainer:singleton("Shared", function()
        return self.shared
    end)

    self.diContainer:singleton("Domain", function()
        return self.shared.domain
    end)

    self.diContainer:singleton("Application", function()
        return self.application
    end)

    self.diContainer:singleton("Presentation", function()
        return self.presentation
    end)

    self.diContainer:singleton("Infrastructure", function()
        return self.infrastructure
    end)

    self.application:init()
    -- self.presentation:init()
end

local client = Client.new()

if ReplicatedStorage:GetAttribute(client.shared.constants.INIT_SERVER) then
    client:init()
else
    ReplicatedStorage:GetAttributeChangedSignal(client.shared.constants.INIT_SERVER):Connect(function()
        client:init()
    end)
end
