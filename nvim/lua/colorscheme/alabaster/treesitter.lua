local treesitter_migrate = function(p)
  local map = {
    ['annotation'] = 'TSAnnotation',

    ['attribute'] = 'TSAttribute',

    ['boolean'] = 'TSBoolean',

    ['character'] = 'TSCharacter',
    ['character.special'] = 'TSCharacterSpecial',

    ['comment'] = 'TSComment',

    ['conditional'] = 'TSConditional',

    ['member'] = 'TSMember',
    ['interface'] = 'TSInterface',

    ['constant'] = 'TSConstant',
    ['constant.builtin'] = 'TSConstBuiltin',
    ['constant.builtin.tsx'] = 'TSBoolean',
    ['constant.macro'] = 'TSConstMacro',

    ['constructor'] = 'TSConstructor',
    ['constructor.lua'] = 'TSPunctBracket',

    ['debug'] = 'TSDebug',
    ['define'] = 'TSDefine',

    ['error'] = 'TSError',
    ['exception'] = 'TSException',

    ['field'] = 'TSField',

    ['float'] = 'TSFloat',

    ['function'] = 'TSFunction',
    ['function.call'] = 'TSFunctionCall',
    ['function.builtin'] = 'TSFuncBuiltin',
    ['function.macro'] = 'TSFuncMacro',

    ['include'] = 'TSInclude',

    ['keyword'] = 'TSKeyword',
    ['keyword.function'] = 'TSKeywordFunction',
    ['keyword.operator'] = 'TSKeywordOperator',
    ['keyword.return'] = 'TSKeywordReturn',

    ['label'] = 'TSLabel',

    ['method'] = 'TSMethod',
    ['method.call'] = 'TSMethodCall',

    ['namespace'] = 'TSNamespace',

    ['none'] = 'TSNone',
    ['number'] = 'TSNumber',

    ['operator'] = 'TSOperator',

    ['parameter'] = 'TSParameter',
    ['parameter.reference'] = 'TSParameterReference',

    ['preproc'] = 'TSPreProc',

    ['property'] = 'TSProperty',

    ['punctuation.delimiter'] = 'TSPunctDelimiter',
    ['punctuation.bracket'] = 'TSPunctBracket',
    ['punctuation.special'] = 'TSPunctSpecial',

    ['repeat'] = 'TSRepeat',

    ['storageclass'] = 'TSStorageClass',

    ['string'] = 'TSString',
    ['string.regex'] = 'TSStringRegex',
    ['string.escape'] = 'TSStringEscape',
    ['string.special'] = 'TSStringSpecial',

    ['symbol'] = 'TSSymbol',

    ['tag'] = 'TSTag',
    ['tag.attribute'] = 'TSTagAttribute',
    ['tag.delimiter'] = 'TSTagDelimiter',

    ['text'] = 'TSText',
    ['text.strong'] = 'TSStrong',
    ['text.emphasis'] = 'TSEmphasis',
    ['text.underline'] = 'TSUnderline',
    ['text.strike'] = 'TSStrike',
    ['text.title'] = 'TSTitle',
    ['text.literal'] = 'TSLiteral',
    ['text.uri'] = 'TSURI',
    ['text.math'] = 'TSMath',
    ['text.reference'] = 'TSTextReference',
    ['text.environment'] = 'TSEnvironment',
    ['text.environment.name'] = 'TSEnvironmentName',

    ['text.note'] = 'TSNote',
    ['text.warning'] = 'TSWarning',
    ['text.danger'] = 'TSDanger',

    ['todo'] = 'TSTodo',

    ['type'] = 'TSType',
    ['type.builtin'] = 'TSTypeBuiltin',
    ['type.qualifier'] = 'TSTypeQualifier',
    ['type.definition'] = 'TSTypeDefinition',

    ['variable'] = 'TSVariable',
    ['variable.builtin'] = 'TSVariableBuiltin',
    ['method.vue'] = 'TSKeyword'
  }

  for capture, hlgroup in pairs(map) do
    vim.api.nvim_set_hl(0, '@' .. capture, { link = hlgroup, default = true })
  end

  local defaults = {
    TSNone = { default = true },
    TSPunctDelimiter = { fg = p.punctuation, default = true },
    TSPunctBracket = { fg = p.fg, default = true },
    TSPunctSpecial = { fg = p.fg, default = true },

    TSConstant = { link = 'Constant', default = true },
    TSConstBuiltin = { link = 'Special', default = true },
    TSConstMacro = { link = 'Define', default = true },
    TSString = { link = 'String', default = true },
    TSStringRegex = { link = 'String', default = true },
    TSStringEscape = { link = 'SpecialChar', default = true },
    TSStringSpecial = { link = 'SpecialChar', default = true },
    TSCharacter = { link = 'Character', default = true },
    TSCharacterSpecial = { link = 'SpecialChar', default = true },
    TSNumber = { link = 'Number', default = true },
    TSBoolean = { link = 'Boolean', default = true },
    TSFloat = { link = 'Float', default = true },

    TSFunction = { link = 'Function', default = true },
    TSFunctionCall = { link = 'TSFunction', default = true },
    TSFuncBuiltin = { link = 'Special', default = true },
    TSFuncMacro = { link = 'Macro', default = true },
    TSParameter = { link = 'Identifier', default = true },
    TSParameterReference = { link = 'TSParameter', default = true },
    TSInterface = { link = 'Interface', default = true },
    TSMethod = { link = 'Function', default = true },
    TSMethodCall = { link = 'TSMethod', default = true },
    TSField = { link = 'Identifier', default = true },
    TSProperty = { link = 'Identifier', default = true },
    TSConstructor = { link = 'Type', default = true },
    TSAnnotation = { link = 'PreProc', default = true },
    TSAttribute = { link = 'PreProc', default = true },
    TSNamespace = { link = 'Include', default = true },
    TSSymbol = { link = 'Identifier', default = true },

    TSConditional = { link = 'Conditional', default = true },
    TSRepeat = { link = 'Repeat', default = true },
    TSLabel = { link = 'Label', default = true },
    TSOperator = { link = 'Operator', default = true },
    TSKeyword = { link = 'Keyword', default = true },
    TSKeywordFunction = { link = 'Keyword', default = true },
    TSKeywordOperator = { link = 'TSOperator', default = true },
    TSKeywordReturn = { link = 'TSKeyword', default = true },
    TSException = { link = 'Exception', default = true },
    TSDebug = { link = 'Debug', default = true },
    TSDefine = { link = 'Define', default = true },
    TSPreProc = { link = 'PreProc', default = true },
    TSStorageClass = { link = 'StorageClass', default = true },
    TSMember = { link = 'Function', default = true },

    TSTodo = { link = 'Todo', default = true },

    TSType = { link = 'Type', default = true },
    TSTypeBuiltin = { fg = p.fg, default = true },
    TSTypeQualifier = { link = 'Keyword', default = true },
    TSTypeDefinition = { link = 'Typedef', default = true },

    TSInclude = { link = 'Include', default = true },

    TSVariableBuiltin = { link = 'Special', default = true },
    TSVariable = { fg = p.fg, default = true },

    TSText = { fg = p.fg1d, default = true },
    TSStrong = { bold = true, default = true },
    TSEmphasis = { italic = true, default = true },
    TSUnderline = { underline = true },
    TSStrike = { strikethrough = true },

    TSMath = { link = 'Special', default = true },
    TSTextReference = { link = 'Constant', default = true },
    TSEnvironment = { link = 'Macro', default = true },
    TSEnvironmentName = { link = 'Type', default = true },
    TSTitle = { link = 'Title', default = true },
    TSLiteral = { link = 'String', default = true },
    TSURI = { link = 'Underlined', default = true },

    TSComment = { link = 'Comment', default = true },
    TSNote = { link = 'SpecialComment', default = true },
    TSWarning = { link = 'Todo', default = true },
    TSDanger = { link = 'WarningMsg', default = true },

    TSTag = { link = 'Tag', default = true },
    TSTagDelimiter = { link = 'Delimiter', default = true },
    TSTagAttribute = { fg = p.fg, default = true },
    typescriptBraces = { link = 'TSPunctBracket' },
    typescriptPredefinedType = { link = 'TSTypeBuiltin' },
    typescriptPromiseStaticMethod = { link = 'TSMethod' },
    typescriptTypeReference = { link = 'Type' },
    tsxAttrib = { link = 'TSTagAttribute' },
    typescriptBOM = { link = 'Function' },
    typescriptArrowFunc = { link = 'Operator' },
    typescriptFuncTypeArrow = { link = 'Operator' },
    typescriptMember = { link = 'Constant' },
    typescriptParens = { link = 'TSPunctBracket' },
    typescriptImport = { link = 'TSKeyword' },
  }

  for group, val in pairs(defaults) do
    vim.api.nvim_set_hl(0, group, val)
  end
end

return treesitter_migrate
