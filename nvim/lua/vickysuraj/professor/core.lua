local secret = "naanum rowdy dhaan"
local stdin_prompt = "."
local M = {}

--- @class ProfessorCmd
--- @field cmd string
--- @field args table<string>

--- @class ProfessorRequest
--- @field query string
--- @field model string

M.url = "http://localhost:4142"

M.default_model = "claude-haiku-4.5"

M.context_id = 424242424242

M.user_id = 'b9ec6bcb-1ecb-4e78-a55d-96099aca3203'

M.query_params = "?history=0&stream=0"

--- @param url string?
--- @return string
M.make_default_ask_url = function(url)
  url = url or M.url
  return url .. "/ask/" .. M.context_id .. M.query_params
end

--- @param prompt string
--- @return boolean
--- returns true/false if the prompt is STDIN
local function is_user_prompt_from_stdin(prompt)
  return prompt == stdin_prompt
end

--- I construct the json-string payload that professor understand
--- @param prompt string
--- @param model_name string?
--- @return ProfessorRequest
M.construct_question_payload = function(prompt, model_name)
  model_name = M.default_model
  return {
    query = prompt,
    model = model_name
  }
end

--- returns the command and args to be sent to professor
--- @param uri string
--- @param prompt string?
--- @param model_name string?
--- @return ProfessorCmd
local function make_professor_curl(uri, prompt, model_name)
  local request_method = "GET"
  local request_body = nil

  if prompt ~= nil then
    request_method = "POST"
    request_body = vim.fn.json_encode(M.construct_question_payload(prompt, model_name))
  end

  local args = {
    uri,
    "-s",
    "-X", request_method,
    "-H", "Accept: application/json",
    "-H", "content-type: application/json",
    "-H", ("user-id: " .. M.user_id),
    "-H", ("X-prof: " .. secret)
  }

  if request_body ~= nil and prompt then
    table.insert(args, "--data-raw")
    if is_user_prompt_from_stdin(prompt) then
      table.insert(args, "@-")
    else
      table.insert(args, request_body)
    end
  end

  return {
    cmd = "curl",
    args = args
  }
end

--- returns the command and args to be sent to professor
--- @param url string
--- @param prompt string
--- @param model_name string?
--- @return ProfessorCmd
M.make_professor_ask = function(url, prompt, model_name)
  return make_professor_curl(
    M.make_default_ask_url(url),
    prompt,
    model_name
  )
end

--- returns list of models supported by professor
M.make_professor_supported_models = function(url)
  return make_professor_curl(
    url .. "/models",
    nil,
    nil
  )
end

return M
