'use strict';
var a5 = require('crypto');
let ad = 0;
const a6 = global.require('./server.config.js')
const a7 = global.GetCurrentResourceName()
const a8 = [a6.range.radio, 100].flat().slice(0, 2)
const ao = {};
const a9 = {};
const aw = {};

for (let [ay, az] of Object.entries(a6.range.vehicle)) {
  a9[global.GetHashKey(ay)] = az;
}

function aa(e) {
  if (e === 'radio') return a8;
  const f = GetEntityModel(e);
  const g = a9[f] ?? a6.range.vehicle['*'];
  return [g, 100].flat().slice(0, 2);
}

const ab = Object.fromEntries(Array.from(a6.blacklist ?? []).map(e => [global.GetHashKey(e), true]));

function ac(e) {
  const f = global.GetEntityModel(e);
  return f in ab;
}

function ae() {
  return ++ad;
}

async function af(e) {
  const f = global.GetPlayerPed(e)
  const [g, h, i] = global.GetEntityCoords(f);
  const j = global.GetHashKey(a6.prop || 'prop_boombox_01')
  const k = global.CreateObject(j, g, h, i - 5, true, true);
  if (!k) {
    console.error('Não foi possível criar a caixa de som [' + k + '] Hash [' + j + ']');
  }
  let l = 0;
  while (!global.DoesEntityExist(k)) {
    await an(50), ++l == 10 && console.error('A caixa de som foi deletada por outro script [' + k + '] Hash [' + j + ']');
  }
  const m = global.NetworkGetNetworkIdFromEntity(k);
  return emit('MQCU:R', m, e), emit('nyo_modules:addSafeEntity', m), emitNet('lafy:hand', e, m), k;
}

function ag(e) {
  const f = {};
  for (let g = 0; g < global.GetNumPlayerIdentifiers(e); g += 1) {
    const [i, j] = global.GetPlayerIdentifier(e, g).split(':');
    f[i] = i + ':' + j;
  }
  return f;
}

async function ah(e, f) {
  const g = a6.permission?.[f] ?? a6.permission;
  return ai(e, g);
}

async function ai(e, f) {
  if (f === false || f == null) {
    return true;
  } else {
    if (Array.isArray(f)) {
      for (const i of f) {
        const k = await ai(e, i);
        if (k) return true;
      }
      return false;
    } else {
      if (f && typeof f === 'object') {
        return false;
      }
    }
  }
  try {
    return exports[a7].hasPermission(e, f);
  } catch (n) {
    console.error('Error on exports#hasPermission');
    if (n instanceof Error) {
      console.error(n);
    } else {
      console.error(String(n));
    }
  }
}

function aj(e, f) {
  if (!e) {
    throw new am(f);
  }
  return e;
}

class am {
  constructor(e) {
    this.message = e;
  }
}

function an(e) {
  return new Promise(f => setTimeout(f, e));
}

class ap {
  static ['all'] = {};
  static ['clientToken'] = null;
  static ['clear'](e) {
    const f = ap.all[e];
    f && (f.clear(), delete ap.all[e]);
  }
  static ['isPlayingAtEntity'](e, f) {
    return Object.values(ap.all).some(g => g.entity === e && g.playerId != f);
  }
  constructor(e, f, g, h, i) {
    this.id = ae(), this.playerId = e, this.range = f, this.url = g, this.volume = h;
    this.entity = 0, this.created_at = i ?? global.GetGameTimer(), ap.all[e] = this;
  }
  ['deleteEntity']() {
    if (global.DoesEntityExist(this.entity)) {
      global.DeleteEntity(this.entity);
    }
  }
  ['refresh'](f) {
    Object.assign(this, f ?? ao);
    const g = {
      ...this
    };
    g.volume = this.volume * this.baseVolume;
    const h = g;
    delete h.entity, delete h.baseVolume;
    if (this.fixed) {
      global.GlobalState['lafy:' + this.id] = h;
    } else {
      if (global.DoesEntityExist(this.entity)) {
        Entity(this.entity).state.lafy = h;
      } else {
        console.log('Failed to refresh entity: ' + this.entity + ' -> [Does not exists]');
      }
    }
    ap.all[this.playerId] = this;
  }
  ['clear']() {
    if (this.fixed) {
      GlobalState['lafy:' + this.id] = null;
    } else {
      if (!this.bluetooth) this.deleteEntity(); else {
        if (global.DoesEntityExist(this.entity)) {
          Entity(this.entity).state.lafy = null;
        }
      }
    }
  }
}

global.on('playerDropped', () => ap.clear(source)), 

global.on('entityRemoved', e => {
  for (const f of Object.values(ap.all)) {
    f.entity == e && delete ap.all[f.playerId];
  }
});

global.on('onResourceStop', e => {
  if (e != a7) return;
  for (const f of Object.values(ap.all)) {
    f.clear();
  }
});

class at extends Error { }
const au = {
  'getTimer': global.GetGameTimer,
  async 'getToken'(e) {
    while (!ap.clientToken) await an(250);
    const f = ag(e)
    const g = f.license ?? f.license2;
    if (!g) {
      throw new at('Source ' + e + ' sem license: ' + JSON.stringify(f));
    }
    const h = Buffer.from(g).toString('base64url')
    const i = a5.createHash('sha256').update(h + 'UxAs9UQxYFwiB7JfwynCYdrEwbI0em21uS0W4LxMydI=').digest('base64url');
    return [ap.clientToken, h.concat('.', i)];
  },
  'isPlaying'(e) {
    return e in ap.all;
  }
};

function av() {
  GlobalState['lafy:dj'] = a6.dj;
  Object.assign(au, {
    async 'play'(h, i, j, k, l) {
      let m = i && NetworkGetEntityFromNetworkId(i);
      if (m) {
        const r = global.GetVehicleType(m);
        aj(!ap.isPlayingAtEntity(m, h), 'Este veículo já está tocando uma música');
        if (ac(m) || r === 'bike' && !a6.allowBluetoothOnBikes || !(await ah(h, 'bluetooth'))) {
          m = 0;
        }
      }
      aj(!m || (await ah(h, 'radio')), 'Você não tem permissão para usar o rádio'), 
      aj(typeof k === 'number' && k >= 0 && k <= 1, 'Volume inválido'), 
      ap.clear(h);
      const [n, o] = aa(m || 'radio')
      const p = new ap(h, n, j, k, l);
      p.baseVolume = o / 100;
      if (m) {
        const t = {};
        t.bluetooth = true, t.entity = m, p.refresh(t);
        const u = {};
        return u.id = p.id, u.mode = 'bluetooth', u;
      } else {
        p.entity = await af(h), p.refresh();
        const x = {};
        return x.id = p.id, x.mode = 'radio', x;
      }
    },
    async 'open_dj'(f, g) {
      const h = a6.dj?.[g];
      return h != null && (await ai(f, h.permission));
    },
    async 'play_dj'(f, g, h, i, j) {
      const k = aj(a6.dj?.[g], 'Mesa de som não encontrada');
      aj(await ai(f, k.permission), 'Você não tem permissão para usar a mesa'), 
      aj(typeof i === 'number' && i >= 0 && i <= 1, 'Volume inválido'), 
      ap.clear(f);
      const l = new ap(f, k.range, h, i, j);
      l.id = 'DJ' + g, l.fixed = k.speaker, l.baseVolume = k.volume / 100, l.refresh();
      const m = {};
      return m.id = l.id, m.mode = 'dj', m;
    },
    'stop'(f) {
      return ap.clear(f), true;
    },
    'resume'(f) {
      const h = ap.all[f];
      if (h && h.paused_at) {
        const j = GetGameTimer() - (h.paused_at - h.created_at);
        delete h.paused_at;
        const k = {};
        return k.created_at = j, h.refresh(k), true;
      }
      return false;
    },
    'pause'(f) {
      const h = ap.all[f];
      if (h && !h.paused_at) {
        return h.refresh({ 'paused_at': GetGameTimer() }), true;
      }
      return false;
    },
    'next'(f, g) {
      const i = ap.all[f];
      if (!i) return false;
      return delete i.paused_at, i.refresh({ 'url': g, 'created_at': GetGameTimer() }), true;
    },
    'setVolume'(f, g) {
      const i = ap.all[f];
      if (!i || typeof g != 'number') return false;
      return i.refresh({ 'volume': Math.max(0, Math.min(1, g)) }), true;
    },
    async 'toggleMode'(f, g) {
      let i = g && NetworkGetEntityFromNetworkId(g);
      const j = aj(ap.all[f], 'Você não está tocando uma música');
      aj(!j.fixed, 'Você não pode mudar o modo desta música');
      if (j.bluetooth) {
        aj(await ah(f, 'radio'), 'Você não tem permissão para usar o rádio');
        const [n, o] = aa('radio')
        const p = await af(f);
        return j.clear(), j.refresh({ 'entity': p, 'id': ae(), 'range': n, 'baseVolume': o / 100, 'bluetooth': false }), 'radio';
      }
      aj(i, 'Você não está em um veículo');
      const k = global.GetVehicleType(i);
      aj(!ac(i), 'Este veículo não possui Bluetooth'), 
      aj(k !== 'bike' || a6.allowBluetoothOnBikes, 'O bluetooth não pode ser emparelhado em motos ou bicicletas'), 
      aj(await ah(f, 'bluetooth'), 'Você não tem permissão para usar o Bluetooth');
      const [l, m] = aa(i);
      return j.clear(), j.refresh({ 'entity': i, 'id': ae(), 'range': l, 'baseVolume': m / 100, 'bluetooth': true }), 'bluetooth';
    }
  });
}

a6.maxDistance && a6.maxDistance != Infinity && setInterval(() => {
  for (const e of Object.values(ap.all)) {
    if (e.entity) {
      const [f, g, h] = global.GetEntityCoords(e.entity)
      const [i, j, k] = global.GetEntityCoords(global.GetPlayerPed(e.playerId))
      const l = Math.sqrt((f - i) ** 2 + (g - j) ** 2 + (h - k) ** 2);
      if (l > a6.maxDistance) {
        e.clear(), 
        emitNet('lafy:maxDistance', e.playerId);
      }
    }
  }
}, 1000);

global.onNet('lafy:req', async (f, g) => {
  const h = global.source;
  while (h in aw) await an(50);
  aw[h] = true;
  try {
    const i = g.shift()
    const j = au[i];
    if (j) {
      const l = await j(h, ...g);
      emitNet('lafy:invoke', h, f, l);
    } else console.error('Method not found: ' + i);
  } catch (o) {
    if (o instanceof am) {
      const q = {};
      return q.error = o.message, emitNet('lafy:invoke', h, f, q);
    } else {
      if (o instanceof at) {
        return console.error(o.message);
      }
    }
    console.error('Um erro ocorreu: ' + o.message), console.error(o.stack);
  } finally {
    delete aw[h];
  }
}), 

global.RegisterCommand(a6.command || 'som', async (e, f) => {
    if (!f.length) {
      if ((await ah(e, 'radio')) || (await ah(e, 'bluetooth'))) {
        return emitNet('lafy:open', e);
      } else {
        return emitNet('lafy:deny', e);
      }
    } else {
      if (Number(f[0])) {
        const j = Math.min(100, Math.max(0, Number(f[0])));
        return emitNet('lafy:volume', e, j);
      }
    }
    emitNet('lafy:toggle', e, f[0] == 'off');
});

global.on("onResourceStart", (resourceName) => {
  if (GetCurrentResourceName() != resourceName) {
    return;
  }
  ap.clientToken = 'pinto', setTimeout(() => console.log("[DURATESTONFY] Autenticado com Sucesso By WeedZZ"), 3600), av();
});