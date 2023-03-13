from glob import glob
from os.path import splitext, basename
from re import match

base_uri = 'ipfs://'
extension = '.png'

layers = [] 

# bg layer
layers.append((glob('1 Backgroun*')[0], False))

# gives us layers 1 - 20
for n in range(4):
  offset = (n + 1) * 5
  i = offset

  layers.append((glob(f'{i} Body*')[0], True))
  layers.append((glob(f'{i+1} Accessories*')[0], True))
  layers.append((glob(f'{i+2} Head*')[0], False))
  layers.append((glob(f'{i+3} Expression*')[0], False))
  layers.append((glob(f'{i+4} Glasses*')[0], False))

layer_result = []

for layer, is_variant in layers:
  properties = []
  properties = glob(f'{layer}/*.png')
  prop_out = sorted([splitext(basename(p))[0] for p in properties])
  layer_result.append((layer, is_variant, prop_out))
  # print(layer, is_variant, len(prop_out))

def get_add_props(target_variable, props):
  items = [f"{target_variable}[{indx}] = \"{prop}\";" for indx, prop in enumerate(props)]
  return "\n".join(items)

def make_fn(layer, is_variant, props):
  result = match(r'^([0-9]+)', layer)
  layer_id = result[1]
  return f'''
    function addLayer{layer_id}(NounsCoasterMetadataRenderer renderer) public {{
      // {layer}
      string[] memory items = new string[]({len(props)});
      {get_add_props('items', props)}
      renderer.addLayer({{
        ipfs: INounsCoasterMetadataRendererTypes.IPFSGroup({{
          baseUri: "{base_uri}",
          extension: "{extension}"
        }}),
        items: items,
        property: "{layer}",
        hasEqualVariants: {is_variant and 'true' or 'false'}
      }});
    }}
  '''

def get_solidity_fn():
  functions = [make_fn(layer, is_variant, props) for (layer, is_variant, props) in layer_result]
  functions_str = "\n".join(functions)
  return f'''
  // SPDX-License-Identifier: MIT
  pragma solidity ^0.8.10;

  import {{NounsCoasterMetadataRenderer}} from "../../src/nouns-coasters/metadata/NounsCoasterMetadataRenderer.sol";
  import {{INounsCoasterMetadataRendererTypes}} from "../../src/nouns-coasters/interfaces/INounsCoasterMetadataRendererTypes.sol";


  library CoasterHelper {{

    {functions_str}


  }}
  '''

print(get_solidity_fn())