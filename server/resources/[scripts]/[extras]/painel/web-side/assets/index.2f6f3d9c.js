(function () {
  const t = document.createElement("link").relList;
  if (t && t.supports && t.supports("modulepreload")) return;
  for (const s of document.querySelectorAll('link[rel="modulepreload"]')) r(s);
  new MutationObserver((s) => {
    for (const c of s)
      if (c.type === "childList")
        for (const l of c.addedNodes)
          l.tagName === "LINK" && l.rel === "modulepreload" && r(l);
  }).observe(document, { childList: !0, subtree: !0 });
  function n(s) {
    const c = {};
    return (
      s.integrity && (c.integrity = s.integrity),
      s.referrerpolicy && (c.referrerPolicy = s.referrerpolicy),
      s.crossorigin === "use-credentials"
        ? (c.credentials = "include")
        : s.crossorigin === "anonymous"
        ? (c.credentials = "omit")
        : (c.credentials = "same-origin"),
      c
    );
  }
  function r(s) {
    if (s.ep) return;
    s.ep = !0;
    const c = n(s);
    fetch(s.href, c);
  }
})();
function re() {}
function Ve(e) {
  return e();
}
function Ee() {
  return Object.create(null);
}
function $(e) {
  e.forEach(Ve);
}
function Ie(e) {
  return typeof e == "function";
}
function Je(e, t) {
  return e != e
    ? t == t
    : e !== t || (e && typeof e == "object") || typeof e == "function";
}
function Qe(e) {
  return Object.keys(e).length === 0;
}
function i(e, t) {
  e.appendChild(t);
}
function q(e, t, n) {
  e.insertBefore(t, n || null);
}
function H(e) {
  e.parentNode.removeChild(e);
}
function ke(e, t) {
  for (let n = 0; n < e.length; n += 1) e[n] && e[n].d(t);
}
function p(e) {
  return document.createElement(e);
}
function Y(e) {
  return document.createElementNS("http://www.w3.org/2000/svg", e);
}
function D(e) {
  return document.createTextNode(e);
}
function k() {
  return D(" ");
}
function Xe() {
  return D("");
}
function W(e, t, n, r) {
  return e.addEventListener(t, n, r), () => e.removeEventListener(t, n, r);
}
function o(e, t, n) {
  n == null
    ? e.removeAttribute(t)
    : e.getAttribute(t) !== n && e.setAttribute(t, n);
}
function pe(e) {
  return e === "" ? null : +e;
}
function Ye(e) {
  return Array.from(e.childNodes);
}
function z(e, t) {
  (t = "" + t), e.wholeText !== t && (e.data = t);
}
function he(e, t) {
  e.value = t == null ? "" : t;
}
function ae(e, t, n) {
  e.classList[n ? "add" : "remove"](t);
}
let ie;
function le(e) {
  ie = e;
}
function $e() {
  if (!ie) throw new Error("Function called outside component initialization");
  return ie;
}
function et(e) {
  $e().$$.on_destroy.push(e);
}
function tt(e, t) {
  const n = e.$$.callbacks[t.type];
  n && n.slice().forEach((r) => r.call(this, t));
}
const oe = [],
  xe = [],
  fe = [],
  Ce = [],
  nt = Promise.resolve();
let ve = !1;
function rt() {
  ve || ((ve = !0), nt.then(De));
}
function we(e) {
  fe.push(e);
}
const ge = new Set();
let ue = 0;
function De() {
  const e = ie;
  do {
    for (; ue < oe.length; ) {
      const t = oe[ue];
      ue++, le(t), st(t.$$);
    }
    for (le(null), oe.length = 0, ue = 0; xe.length; ) xe.pop()();
    for (let t = 0; t < fe.length; t += 1) {
      const n = fe[t];
      ge.has(n) || (ge.add(n), n());
    }
    fe.length = 0;
  } while (oe.length);
  for (; Ce.length; ) Ce.pop()();
  (ve = !1), ge.clear(), le(e);
}
function st(e) {
  if (e.fragment !== null) {
    e.update(), $(e.before_update);
    const t = e.dirty;
    (e.dirty = [-1]),
      e.fragment && e.fragment.p(e.ctx, t),
      e.after_update.forEach(we);
  }
}
const ot = new Set();
function lt(e, t) {
  e && e.i && (ot.delete(e), e.i(t));
}
function it(e, t, n, r) {
  const { fragment: s, after_update: c } = e.$$;
  s && s.m(t, n),
    r ||
      we(() => {
        const l = e.$$.on_mount.map(Ve).filter(Ie);
        e.$$.on_destroy ? e.$$.on_destroy.push(...l) : $(l),
          (e.$$.on_mount = []);
      }),
    c.forEach(we);
}
function ct(e, t) {
  const n = e.$$;
  n.fragment !== null &&
    ($(n.on_destroy),
    n.fragment && n.fragment.d(t),
    (n.on_destroy = n.fragment = null),
    (n.ctx = []));
}
function at(e, t) {
  e.$$.dirty[0] === -1 && (oe.push(e), rt(), e.$$.dirty.fill(0)),
    (e.$$.dirty[(t / 31) | 0] |= 1 << t % 31);
}
function ut(e, t, n, r, s, c, l, u = [-1]) {
  const d = ie;
  le(e);
  const h = (e.$$ = {
    fragment: null,
    ctx: [],
    props: c,
    update: re,
    not_equal: s,
    bound: Ee(),
    on_mount: [],
    on_destroy: [],
    on_disconnect: [],
    before_update: [],
    after_update: [],
    context: new Map(t.context || (d ? d.$$.context : [])),
    callbacks: Ee(),
    dirty: u,
    skip_bound: !1,
    root: t.target || d.$$.root,
  });
  l && l(h.root);
  let f = !1;
  if (
    ((h.ctx = n
      ? n(e, t.props || {}, (a, v, ...m) => {
          const _ = m.length ? m[0] : v;
          return (
            h.ctx &&
              s(h.ctx[a], (h.ctx[a] = _)) &&
              (!h.skip_bound && h.bound[a] && h.bound[a](_), f && at(e, a)),
            v
          );
        })
      : []),
    h.update(),
    (f = !0),
    $(h.before_update),
    (h.fragment = r ? r(h.ctx) : !1),
    t.target)
  ) {
    if (t.hydrate) {
      const a = Ye(t.target);
      h.fragment && h.fragment.l(a), a.forEach(H);
    } else h.fragment && h.fragment.c();
    t.intro && lt(e.$$.fragment),
      it(e, t.target, t.anchor, t.customElement),
      De();
  }
  le(d);
}
class ft {
  $destroy() {
    ct(this, 1), (this.$destroy = re);
  }
  $on(t, n) {
    if (!Ie(n)) return re;
    const r = this.$$.callbacks[t] || (this.$$.callbacks[t] = []);
    return (
      r.push(n),
      () => {
        const s = r.indexOf(n);
        s !== -1 && r.splice(s, 1);
      }
    );
  }
  $set(t) {
    this.$$set &&
      !Qe(t) &&
      ((this.$$.skip_bound = !0), this.$$set(t), (this.$$.skip_bound = !1));
  }
}
var Le = { exports: {} },
  ne = typeof Reflect == "object" ? Reflect : null,
  je =
    ne && typeof ne.apply == "function"
      ? ne.apply
      : function (t, n, r) {
          return Function.prototype.apply.call(t, n, r);
        },
  de;
ne && typeof ne.ownKeys == "function"
  ? (de = ne.ownKeys)
  : Object.getOwnPropertySymbols
  ? (de = function (t) {
      return Object.getOwnPropertyNames(t).concat(
        Object.getOwnPropertySymbols(t)
      );
    })
  : (de = function (t) {
      return Object.getOwnPropertyNames(t);
    });
function dt(e) {
  console && console.warn && console.warn(e);
}
var He =
  Number.isNaN ||
  function (t) {
    return t !== t;
  };
function x() {
  x.init.call(this);
}
Le.exports = x;
Le.exports.once = _t;
x.EventEmitter = x;
x.prototype._events = void 0;
x.prototype._eventsCount = 0;
x.prototype._maxListeners = void 0;
var Oe = 10;
function _e(e) {
  if (typeof e != "function")
    throw new TypeError(
      'The "listener" argument must be of type Function. Received type ' +
        typeof e
    );
}
Object.defineProperty(x, "defaultMaxListeners", {
  enumerable: !0,
  get: function () {
    return Oe;
  },
  set: function (e) {
    if (typeof e != "number" || e < 0 || He(e))
      throw new RangeError(
        'The value of "defaultMaxListeners" is out of range. It must be a non-negative number. Received ' +
          e +
          "."
      );
    Oe = e;
  },
});
x.init = function () {
  (this._events === void 0 ||
    this._events === Object.getPrototypeOf(this)._events) &&
    ((this._events = Object.create(null)), (this._eventsCount = 0)),
    (this._maxListeners = this._maxListeners || void 0);
};
x.prototype.setMaxListeners = function (t) {
  if (typeof t != "number" || t < 0 || He(t))
    throw new RangeError(
      'The value of "n" is out of range. It must be a non-negative number. Received ' +
        t +
        "."
    );
  return (this._maxListeners = t), this;
};
function Ke(e) {
  return e._maxListeners === void 0 ? x.defaultMaxListeners : e._maxListeners;
}
x.prototype.getMaxListeners = function () {
  return Ke(this);
};
x.prototype.emit = function (t) {
  for (var n = [], r = 1; r < arguments.length; r++) n.push(arguments[r]);
  var s = t === "error",
    c = this._events;
  if (c !== void 0) s = s && c.error === void 0;
  else if (!s) return !1;
  if (s) {
    var l;
    if ((n.length > 0 && (l = n[0]), l instanceof Error)) throw l;
    var u = new Error("Unhandled error." + (l ? " (" + l.message + ")" : ""));
    throw ((u.context = l), u);
  }
  var d = c[t];
  if (d === void 0) return !1;
  if (typeof d == "function") je(d, this, n);
  else
    for (var h = d.length, f = ze(d, h), r = 0; r < h; ++r) je(f[r], this, n);
  return !0;
};
function Ue(e, t, n, r) {
  var s, c, l;
  if (
    (_e(n),
    (c = e._events),
    c === void 0
      ? ((c = e._events = Object.create(null)), (e._eventsCount = 0))
      : (c.newListener !== void 0 &&
          (e.emit("newListener", t, n.listener ? n.listener : n),
          (c = e._events)),
        (l = c[t])),
    l === void 0)
  )
    (l = c[t] = n), ++e._eventsCount;
  else if (
    (typeof l == "function"
      ? (l = c[t] = r ? [n, l] : [l, n])
      : r
      ? l.unshift(n)
      : l.push(n),
    (s = Ke(e)),
    s > 0 && l.length > s && !l.warned)
  ) {
    l.warned = !0;
    var u = new Error(
      "Possible EventEmitter memory leak detected. " +
        l.length +
        " " +
        String(t) +
        " listeners added. Use emitter.setMaxListeners() to increase limit"
    );
    (u.name = "MaxListenersExceededWarning"),
      (u.emitter = e),
      (u.type = t),
      (u.count = l.length),
      dt(u);
  }
  return e;
}
x.prototype.addListener = function (t, n) {
  return Ue(this, t, n, !1);
};
x.prototype.on = x.prototype.addListener;
x.prototype.prependListener = function (t, n) {
  return Ue(this, t, n, !0);
};
function pt() {
  if (!this.fired)
    return (
      this.target.removeListener(this.type, this.wrapFn),
      (this.fired = !0),
      arguments.length === 0
        ? this.listener.call(this.target)
        : this.listener.apply(this.target, arguments)
    );
}
function We(e, t, n) {
  var r = { fired: !1, wrapFn: void 0, target: e, type: t, listener: n },
    s = pt.bind(r);
  return (s.listener = n), (r.wrapFn = s), s;
}
x.prototype.once = function (t, n) {
  return _e(n), this.on(t, We(this, t, n)), this;
};
x.prototype.prependOnceListener = function (t, n) {
  return _e(n), this.prependListener(t, We(this, t, n)), this;
};
x.prototype.removeListener = function (t, n) {
  var r, s, c, l, u;
  if ((_e(n), (s = this._events), s === void 0)) return this;
  if (((r = s[t]), r === void 0)) return this;
  if (r === n || r.listener === n)
    --this._eventsCount === 0
      ? (this._events = Object.create(null))
      : (delete s[t],
        s.removeListener && this.emit("removeListener", t, r.listener || n));
  else if (typeof r != "function") {
    for (c = -1, l = r.length - 1; l >= 0; l--)
      if (r[l] === n || r[l].listener === n) {
        (u = r[l].listener), (c = l);
        break;
      }
    if (c < 0) return this;
    c === 0 ? r.shift() : ht(r, c),
      r.length === 1 && (s[t] = r[0]),
      s.removeListener !== void 0 && this.emit("removeListener", t, u || n);
  }
  return this;
};
x.prototype.off = x.prototype.removeListener;
x.prototype.removeAllListeners = function (t) {
  var n, r, s;
  if (((r = this._events), r === void 0)) return this;
  if (r.removeListener === void 0)
    return (
      arguments.length === 0
        ? ((this._events = Object.create(null)), (this._eventsCount = 0))
        : r[t] !== void 0 &&
          (--this._eventsCount === 0
            ? (this._events = Object.create(null))
            : delete r[t]),
      this
    );
  if (arguments.length === 0) {
    var c = Object.keys(r),
      l;
    for (s = 0; s < c.length; ++s)
      (l = c[s]), l !== "removeListener" && this.removeAllListeners(l);
    return (
      this.removeAllListeners("removeListener"),
      (this._events = Object.create(null)),
      (this._eventsCount = 0),
      this
    );
  }
  if (((n = r[t]), typeof n == "function")) this.removeListener(t, n);
  else if (n !== void 0)
    for (s = n.length - 1; s >= 0; s--) this.removeListener(t, n[s]);
  return this;
};
function qe(e, t, n) {
  var r = e._events;
  if (r === void 0) return [];
  var s = r[t];
  return s === void 0
    ? []
    : typeof s == "function"
    ? n
      ? [s.listener || s]
      : [s]
    : n
    ? mt(s)
    : ze(s, s.length);
}
x.prototype.listeners = function (t) {
  return qe(this, t, !0);
};
x.prototype.rawListeners = function (t) {
  return qe(this, t, !1);
};
x.listenerCount = function (e, t) {
  return typeof e.listenerCount == "function"
    ? e.listenerCount(t)
    : Ze.call(e, t);
};
x.prototype.listenerCount = Ze;
function Ze(e) {
  var t = this._events;
  if (t !== void 0) {
    var n = t[e];
    if (typeof n == "function") return 1;
    if (n !== void 0) return n.length;
  }
  return 0;
}
x.prototype.eventNames = function () {
  return this._eventsCount > 0 ? de(this._events) : [];
};
function ze(e, t) {
  for (var n = new Array(t), r = 0; r < t; ++r) n[r] = e[r];
  return n;
}
function ht(e, t) {
  for (; t + 1 < e.length; t++) e[t] = e[t + 1];
  e.pop();
}
function mt(e) {
  for (var t = new Array(e.length), n = 0; n < t.length; ++n)
    t[n] = e[n].listener || e[n];
  return t;
}
function _t(e, t) {
  return new Promise(function (n, r) {
    function s(l) {
      e.removeListener(t, c), r(l);
    }
    function c() {
      typeof e.removeListener == "function" && e.removeListener("error", s),
        n([].slice.call(arguments));
    }
    Ge(e, t, c, { once: !0 }), t !== "error" && bt(e, s, { once: !0 });
  });
}
function bt(e, t, n) {
  typeof e.on == "function" && Ge(e, "error", t, n);
}
function Ge(e, t, n, r) {
  if (typeof e.on == "function") r.once ? e.once(t, n) : e.on(t, n);
  else if (typeof e.addEventListener == "function")
    e.addEventListener(t, function s(c) {
      r.once && e.removeEventListener(t, s), n(c);
    });
  else
    throw new TypeError(
      'The "emitter" argument must be of type EventEmitter. Received type ' +
        typeof e
    );
}
const ye = new Le.exports.EventEmitter();
addEventListener("message", (e) => ye.emit(e.data.name, e.data.payload));
function gt(e, t) {
  ye.on(e, t), et(() => ye.removeListener(e, t));
}
async function ee(e, t) {
  return fetch(`http://${GetParentResourceName()}/${e}`, {
    method: "POST",
    body: JSON.stringify(t),
  })
    .then((n) => n.json())
    .catch((n) => console.error("Erro de solita\xE7\xE3o", n));
}
function me(e) {
  return new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
  }).format(e);
}
const Me = (t) => {
  for (var t = t.toString(), n = "", r = 0, s = t.length; s > 0; s--)
    (n += t.substr(s - 1, 1) + (r == 2 && s != 1 ? "." : "")),
      (r = r == 2 ? 0 : r + 1);
  return n.split("").reverse().join("");
};
function Ne(e, t, n) {
  const r = e.slice();
  return (r[40] = t[n]), r;
}
function Te(e, t, n) {
  const r = e.slice();
  return (r[37] = t[n]), r;
}
function Fe(e, t, n) {
  const r = e.slice();
  return (r[14] = t[n]), r;
}
function Pe(e) {
  let t,
    n,
    r,
    s,
    c,
    l,
    u,
    d,
    h,
    f,
    a,
    v,
    m,
    _,
    M = (e[3] ? e[3] : "Comprar") + "",
    j,
    C,
    T,
    S,
    R,
    F,
    Z,
    O,
    B,
    A,
    V,
    L = e[2] && Be(e);
  function N(w, P) {
    return w[3] ? vt : wt;
  }
  let b = N(e),
    E = b(e);
  function y(w, P) {
    return w[1] ? kt : yt;
  }
  let K = y(e),
    I = K(e);
  return {
    c() {
      (t = p("main")),
        (n = p("section")),
        (r = p("section")),
        (s = p("section")),
        (c = p("span")),
        (c.textContent = "Painel"),
        (l = k()),
        (u = p("span")),
        (d = D(e[7])),
        (h = k()),
        (f = p("section")),
        (a = p("section")),
        L && L.c(),
        (v = k()),
        E.c(),
        (m = k()),
        (_ = p("button")),
        (j = D(M)),
        (C = k()),
        (T = p("hr")),
        (S = k()),
        (R = p("section")),
        (F = p("button")),
        (F.textContent = "Painel"),
        (Z = k()),
        (O = p("button")),
        (O.textContent = "Banco"),
        (B = k()),
        I.c(),
        o(c, "class", "text-[2.5rem] font-semibold"),
        o(u, "class", "text-2xl text-cr font-medium"),
        o(s, "class", "flex flex-col -space-y-4"),
        o(a, "class", "relative flex items-center justify-around"),
        (_.disabled = e[3]),
        o(
          _,
          "class",
          "w-[6.375rem] h-7 text-sm font-medium bg-cr hover:[box-shadow:0_0_2.1875rem_rgba(245,10,70,0.35)] rounded uppercase"
        ),
        o(
          f,
          "class",
          "w-[6.375rem] h-[3.4375rem] flex flex-col space-y-3 justify-between"
        ),
        o(
          r,
          "class",
          "w-full mb-[2.5625rem] flex items-center justify-between"
        ),
        o(
          T,
          "class",
          "h-[49.625rem] fixed left-[5.375rem] border-l-2 border-cr/30 rounded-lg"
        ),
        o(
          F,
          "class",
          "w-[10.6875rem] h-9 text-white/50 bg-black/0 rounded-l svelte-tjh505"
        ),
        ae(F, "active", e[1]),
        o(
          O,
          "class",
          "w-[10.6875rem] h-9 text-white/50 bg-black/0 rounded-r svelte-tjh505"
        ),
        ae(O, "active", !e[1]),
        o(R, "class", "mb-2 flex bg-black/50 rounded"),
        o(n, "class", "w-[21.375rem] h-[56.8rem] ml-[8.0625rem]"),
        o(
          t,
          "class",
          "fixed inset-0 grid items-center justify-start font-poppins text-white " +
            (location.port === "5173" && "bg-black/50") +
            ' bg-[url("./assets/bg_cr.png")] bg-no-repeat bg-cover select-none svelte-tjh505'
        );
    },
    m(w, P) {
      q(w, t, P),
        i(t, n),
        i(n, r),
        i(r, s),
        i(s, c),
        i(s, l),
        i(s, u),
        i(u, d),
        i(r, h),
        i(r, f),
        i(f, a),
        L && L.m(a, null),
        i(a, v),
        E.m(a, null),
        i(f, m),
        i(f, _),
        i(_, j),
        i(n, C),
        i(n, T),
        i(n, S),
        i(n, R),
        i(R, F),
        i(R, Z),
        i(R, O),
        i(n, B),
        I.m(n, null),
        A ||
          ((V = [
            W(a, "focus", e[21]),
            W(a, "pointerover", e[22]),
            W(a, "pointerleave", e[23]),
            W(_, "click", e[24]),
            W(F, "click", e[25]),
            W(O, "click", e[26]),
          ]),
          (A = !0));
    },
    p(w, P) {
      P[0] & 128 && z(d, w[7]),
        w[2]
          ? L
            ? L.p(w, P)
            : ((L = Be(w)), L.c(), L.m(a, v))
          : L && (L.d(1), (L = null)),
        b === (b = N(w)) && E
          ? E.p(w, P)
          : (E.d(1), (E = b(w)), E && (E.c(), E.m(a, null))),
        P[0] & 8 && M !== (M = (w[3] ? w[3] : "Comprar") + "") && z(j, M),
        P[0] & 8 && (_.disabled = w[3]),
        P[0] & 2 && ae(F, "active", w[1]),
        P[0] & 2 && ae(O, "active", !w[1]),
        K === (K = y(w)) && I
          ? I.p(w, P)
          : (I.d(1), (I = K(w)), I && (I.c(), I.m(n, null)));
    },
    d(w) {
      w && H(t), L && L.d(), E.d(), I.d(), (A = !1), $(V);
    },
  };
}
function Be(e) {
  let t,
    n,
    r,
    s,
    c,
    l = e[14],
    u = [];
  for (let d = 0; d < l.length; d += 1) u[d] = Ae(Fe(e, l, d));
  return {
    c() {
      (t = p("section")),
        (n = p("section")),
        (r = p("span")),
        (r.textContent = "Benef\xEDcios"),
        (s = k()),
        (c = p("section"));
      for (let d = 0; d < u.length; d += 1) u[d].c();
      o(r, "class", "text-sm text-cr font-medium"),
        o(c, "class", "flex flex-col space-y-1"),
        o(n, "class", "p-[1.625rem] space-y-2"),
        o(
          t,
          "class",
          "w-[21.375rem] h-fit absolute top-0 left-32 [background:_linear-gradient(0deg,_rgba(0,_0,_0,_0.58),_rgba(0,_0,_0,_0.58)),_linear-gradient(139.55deg,_#f50a46_-56.15%,_rgba(65,_130,_226,_0)_75.82%)] rounded"
        );
    },
    m(d, h) {
      q(d, t, h), i(t, n), i(n, r), i(n, s), i(n, c);
      for (let f = 0; f < u.length; f += 1) u[f].m(c, null);
    },
    p(d, h) {
      if (h[0] & 16384) {
        l = d[14];
        let f;
        for (f = 0; f < l.length; f += 1) {
          const a = Fe(d, l, f);
          u[f] ? u[f].p(a, h) : ((u[f] = Ae(a)), u[f].c(), u[f].m(c, null));
        }
        for (; f < u.length; f += 1) u[f].d(1);
        u.length = l.length;
      }
    },
    d(d) {
      d && H(t), ke(u, d);
    },
  };
}
function Ae(e) {
  let t,
    n = e[14] + "";
  return {
    c() {
      (t = p("span")), o(t, "class", "text-xs font-normal");
    },
    m(r, s) {
      q(r, t, s), (t.innerHTML = n);
    },
    p(r, s) {
      s[0] & 16384 && n !== (n = r[14] + "") && (t.innerHTML = n);
    },
    d(r) {
      r && H(t);
    },
  };
}
function vt(e) {
  let t;
  return {
    c() {
      (t = p("span")),
        (t.textContent = "Dias Restantes"),
        o(t, "class", "text-xs text-white/50 uppercase");
    },
    m(n, r) {
      q(n, t, r);
    },
    p: re,
    d(n) {
      n && H(t);
    },
  };
}
function wt(e) {
  let t,
    n,
    r,
    s = Me(e[4]) + "",
    c;
  return {
    c() {
      (t = p("span")),
        (t.textContent = "Boost"),
        (n = k()),
        (r = p("span")),
        (c = D(s)),
        o(t, "class", "text-sm font-normal"),
        o(r, "class", "text-xs text-white/50");
    },
    m(l, u) {
      q(l, t, u), q(l, n, u), q(l, r, u), i(r, c);
    },
    p(l, u) {
      u[0] & 16 && s !== (s = Me(l[4]) + "") && z(c, s);
    },
    d(l) {
      l && H(t), l && H(n), l && H(r);
    },
  };
}
function yt(e) {
  let t,
    n,
    r,
    s,
    c,
    l,
    u,
    d = me(e[11]) + "",
    h,
    f,
    a,
    v,
    m,
    _,
    M,
    j,
    C,
    T,
    S,
    R,
    F,
    Z,
    O,
    B,
    A,
    V,
    L = e[6],
    N = [];
  for (let b = 0; b < L.length; b += 1) N[b] = Re(Ne(e, L, b));
  return {
    c() {
      (t = p("section")),
        (n = p("section")),
        (r = p("section")),
        (s = p("section")),
        (c = p("span")),
        (c.textContent = "Saldo"),
        (l = k()),
        (u = p("span")),
        (h = D(d)),
        (f = k()),
        (a = p("section")),
        (v = p("input")),
        (m = k()),
        (_ = p("section")),
        (M = p("button")),
        (j = D(e[13])),
        (C = k()),
        (T = p("button")),
        (S = D(e[12])),
        (R = k()),
        (F = p("table")),
        (Z = p("thead")),
        (Z.innerHTML = `<tr class="text-left"><th class="w-[9.4375rem] pl-1 text-xs text-white/50 font-normal uppercase">Hist\xF3rico</th> 
                <th class="w-[9.4375rem] pl-1 text-xs text-white/50 font-normal uppercase">Valor</th></tr>`),
        (O = k()),
        (B = p("tbody"));
      for (let b = 0; b < N.length; b += 1) N[b].c();
      o(c, "class", "text-cr/30"),
        o(u, "class", "text-4xl font-semibold"),
        o(s, "class", "grid gap-1"),
        o(
          v,
          "class",
          "w-[18.4375rem] h-[2.625rem] pl-6 pr-[9rem] placeholder:text-cr/30 focus:outline-none bg-cr/10 rounded"
        ),
        o(v, "placeholder", "Valor"),
        o(v, "type", "number"),
        o(M, "class", "text-xs text-white/50 font-normal"),
        o(
          T,
          "class",
          "w-[8.25rem] h-[2.625rem] bg-cr hover:[box-shadow:0_0_2.1875rem_rgba(245,10,70,0.35)] rounded"
        ),
        o(_, "class", "absolute bottom-0 right-0 grid gap-2"),
        o(a, "class", "relative"),
        o(r, "class", "h-full grid gap-1 items-center justify-between"),
        o(n, "class", "w-[21.375rem] h-[12.0625rem] px-6 bg-black/50 rounded"),
        o(
          B,
          "class",
          "max-h-[30rem] block space-y-1 overflow-auto no-scrollbar"
        ),
        o(
          F,
          "class",
          "w-[21.375rem] h-[34.3125rem] p-5 space-y-2 table-cell table-fixed border-collapse bg-black/50 rounded"
        ),
        o(t, "class", "grid gap-2");
    },
    m(b, E) {
      q(b, t, E),
        i(t, n),
        i(n, r),
        i(r, s),
        i(s, c),
        i(s, l),
        i(s, u),
        i(u, h),
        i(r, f),
        i(r, a),
        i(a, v),
        he(v, e[10]),
        i(a, m),
        i(a, _),
        i(_, M),
        i(M, j),
        i(_, C),
        i(_, T),
        i(T, S),
        i(t, R),
        i(t, F),
        i(F, Z),
        i(F, O),
        i(F, B);
      for (let y = 0; y < N.length; y += 1) N[y].m(B, null);
      A ||
        ((V = [
          W(v, "input", e[32]),
          W(M, "click", e[33]),
          W(T, "click", e[34]),
        ]),
        (A = !0));
    },
    p(b, E) {
      if (
        (E[0] & 2048 && d !== (d = me(b[11]) + "") && z(h, d),
        E[0] & 1024 && pe(v.value) !== b[10] && he(v, b[10]),
        E[0] & 8192 && z(j, b[13]),
        E[0] & 4096 && z(S, b[12]),
        E[0] & 64)
      ) {
        L = b[6];
        let y;
        for (y = 0; y < L.length; y += 1) {
          const K = Ne(b, L, y);
          N[y] ? N[y].p(K, E) : ((N[y] = Re(K)), N[y].c(), N[y].m(B, null));
        }
        for (; y < N.length; y += 1) N[y].d(1);
        N.length = L.length;
      }
    },
    d(b) {
      b && H(t), ke(N, b), (A = !1), $(V);
    },
  };
}
function kt(e) {
  let t,
    n,
    r,
    s,
    c,
    l,
    u,
    d,
    h = e[5],
    f = [];
  for (let a = 0; a < h.length; a += 1) f[a] = Se(Te(e, h, a));
  return {
    c() {
      (t = p("section")),
        (n = p("input")),
        (r = k()),
        (s = p("button")),
        (s.textContent = "Adicionar"),
        (c = k()),
        (l = p("section"));
      for (let a = 0; a < f.length; a += 1) f[a].c();
      o(
        n,
        "class",
        "w-[13.6875rem] h-[2.625rem] px-[1.0625rem] placeholder:text-cr/30 focus:outline-none bg-black/60 rounded"
      ),
        o(n, "placeholder", "Passaporte"),
        o(n, "type", "number"),
        o(
          s,
          "class",
          "w-[7.1875rem] h-[2.625rem] text-sm font-medium bg-cr hover:[box-shadow:0_0_2.1875rem_rgba(245,10,70,0.35)] rounded uppercase"
        ),
        o(t, "class", "mb-2 flex gap-2"),
        o(
          l,
          "class",
          "max-h-[43.75rem] block space-y-2 overflow-auto no-scrollbar"
        );
    },
    m(a, v) {
      q(a, t, v),
        i(t, n),
        he(n, e[9]),
        i(t, r),
        i(t, s),
        q(a, c, v),
        q(a, l, v);
      for (let m = 0; m < f.length; m += 1) f[m].m(l, null);
      u || ((d = [W(n, "input", e[27]), W(s, "click", e[28])]), (u = !0));
    },
    p(a, v) {
      if ((v[0] & 512 && pe(n.value) !== a[9] && he(n, a[9]), v[0] & 393504)) {
        h = a[5];
        let m;
        for (m = 0; m < h.length; m += 1) {
          const _ = Te(a, h, m);
          f[m] ? f[m].p(_, v) : ((f[m] = Se(_)), f[m].c(), f[m].m(l, null));
        }
        for (; m < f.length; m += 1) f[m].d(1);
        f.length = h.length;
      }
    },
    d(a) {
      a && H(t), a && H(c), a && H(l), ke(f, a), (u = !1), $(d);
    },
  };
}
function Re(e) {
  let t,
    n,
    r,
    s,
    c,
    l,
    u,
    d,
    h,
    f = e[40].Type == "entry" ? "Entrada" : "Sa\xEDda",
    a,
    v,
    m,
    _ = me(e[40].Value) + "",
    M,
    j;
  return {
    c() {
      (t = p("tr")),
        (n = p("td")),
        (r = p("section")),
        (s = Y("svg")),
        (c = Y("path")),
        (d = k()),
        (h = p("span")),
        (a = D(f)),
        (v = k()),
        (m = p("td")),
        (M = D(_)),
        (j = k()),
        o(
          c,
          "class",
          (l = e[40].Type == "entry" ? "stroke-[#00BC7E]" : "stroke-[#F64740]")
        ),
        o(c, "stroke-linecap", "round"),
        o(c, "stroke-linejoin", "round"),
        o(
          c,
          "d",
          "M4.74196 7.74196V10.3226M12.4839 6.45164V9.03228M11.8387 3.22583C13.4185 3.22583 14.273 3.46761 14.6982 3.65515C14.7548 3.68012 14.7831 3.69261 14.8648 3.77059C14.9138 3.81733 15.0032 3.95447 15.0262 4.01815C15.0645 4.12437 15.0645 4.18244 15.0645 4.29857V11.233C15.0645 11.8193 15.0645 12.1125 14.9766 12.2632C14.8872 12.4164 14.8009 12.4877 14.6335 12.5466C14.469 12.6045 14.1368 12.5407 13.4724 12.413C13.0074 12.3237 12.4558 12.2581 11.8387 12.2581C9.90325 12.2581 7.96777 13.5484 5.38712 13.5484C3.80731 13.5484 2.95284 13.3066 2.52769 13.1191C2.47107 13.0941 2.44276 13.0816 2.36106 13.0037C2.31208 12.9569 2.22268 12.8198 2.19968 12.7561C2.16132 12.6499 2.16132 12.5918 2.16132 12.4757L2.16132 5.54122C2.16132 4.95492 2.16132 4.66177 2.24924 4.51108C2.33867 4.35781 2.42492 4.28655 2.59232 4.22764C2.75689 4.16973 3.08908 4.23356 3.75346 4.36122C4.21849 4.45057 4.77001 4.51615 5.38712 4.51615C7.32261 4.51615 9.25809 3.22583 11.8387 3.22583ZM10.2258 8.38712C10.2258 9.2779 9.50371 10 8.61293 10C7.72215 10 7.00003 9.2779 7.00003 8.38712C7.00003 7.49634 7.72215 6.77422 8.61293 6.77422C9.50371 6.77422 10.2258 7.49634 10.2258 8.38712Z"
        ),
        o(s, "width", "17"),
        o(s, "height", "17"),
        o(s, "viewBox", "0 0 17 17"),
        o(s, "fill", "none"),
        o(s, "xmlns", "http://www.w3.org/2000/svg"),
        o(
          r,
          "class",
          (u =
            "w-6 h-6 grid place-items-center " +
            (e[40].Type == "entry" ? "bg-cr/10" : "bg-[#F64740]/10") +
            " rounded")
        ),
        o(h, "class", "text-sm font-normal"),
        o(n, "class", "w-[9.4375rem] flex items-center gap-x-2"),
        o(m, "class", "w-[9.4375rem] text-sm font-normal"),
        o(
          t,
          "class",
          "w-[18.875rem] h-9 px-2 flex place-items-center odd:bg-cr/5 even:bg-transparent rounded"
        );
    },
    m(C, T) {
      q(C, t, T),
        i(t, n),
        i(n, r),
        i(r, s),
        i(s, c),
        i(n, d),
        i(n, h),
        i(h, a),
        i(t, v),
        i(t, m),
        i(m, M),
        i(t, j);
    },
    p(C, T) {
      T[0] & 64 &&
        l !==
          (l =
            C[40].Type == "entry" ? "stroke-[#00BC7E]" : "stroke-[#F64740]") &&
        o(c, "class", l),
        T[0] & 64 &&
          u !==
            (u =
              "w-6 h-6 grid place-items-center " +
              (C[40].Type == "entry" ? "bg-cr/10" : "bg-[#F64740]/10") +
              " rounded") &&
          o(r, "class", u),
        T[0] & 64 &&
          f !== (f = C[40].Type == "entry" ? "Entrada" : "Sa\xEDda") &&
          z(a, f),
        T[0] & 64 && _ !== (_ = me(C[40].Value) + "") && z(M, _);
    },
    d(C) {
      C && H(t);
    },
  };
}
function Se(e) {
  let t,
    n,
    r,
    s,
    c,
    l,
    u,
    d,
    h = e[37].id + "",
    f,
    a,
    v = e[37].name + "",
    m,
    _,
    M,
    j = e[37].phone + "",
    C,
    T,
    S,
    R = e[37].role + "",
    F,
    Z,
    O,
    B,
    A,
    V,
    L,
    N,
    b,
    E,
    y,
    K,
    I,
    w,
    P,
    J,
    te,
    be,
    ce,
    g;
  function U() {
    return e[29](e[37]);
  }
  function Q() {
    return e[30](e[37]);
  }
  function X() {
    return e[31](e[37]);
  }
  return {
    c() {
      (t = p("section")),
        (n = p("section")),
        (s = k()),
        (c = p("section")),
        (l = p("span")),
        (u = p("b")),
        (d = D("#")),
        (f = D(h)),
        (a = k()),
        (m = D(v)),
        (_ = k()),
        (M = p("span")),
        (C = D(j)),
        (T = k()),
        (S = p("span")),
        (F = D(R)),
        (Z = k()),
        (O = p("section")),
        (B = p("button")),
        (A = Y("svg")),
        (V = Y("path")),
        (N = k()),
        (b = p("button")),
        (E = Y("svg")),
        (y = Y("path")),
        (I = k()),
        (w = p("button")),
        (P = Y("svg")),
        (J = Y("path")),
        (be = k()),
        o(
          n,
          "class",
          (r =
            "w-2 h-2 absolute mt-1 left-[1.1875rem] " +
            (e[37].online
              ? "bg-[#00BC7E] [box-shadow:0_0_0.625rem_rgba(245,10,70,0.4)]"
              : "bg-[#F64740] [box-shadow:0_0_0.625rem_rgba(246,71,64,0.4)]") +
            " rounded-[0.1875rem]")
        ),
        o(u, "class", "svelte-tjh505"),
        o(l, "class", "text-base font-normal"),
        o(M, "class", "text-sm text-white/50 font-normal"),
        o(S, "class", "text-sm text-cr font-normal"),
        o(
          c,
          "class",
          "absolute left-[2.6875rem] flex flex-col place-items-start gap-1"
        ),
        o(V, "stroke", "#00BC7E"),
        o(V, "stroke-width", "2"),
        o(V, "stroke-linecap", "round"),
        o(V, "stroke-linejoin", "round"),
        o(
          V,
          "d",
          "M11 17.4167V4.58337M11 4.58337L4.58331 11M11 4.58337L17.4166 11"
        ),
        o(A, "class", "w-[1.375rem] h-[1.375rem] fill-none"),
        o(A, "viewBox", "0 0 22 22"),
        o(A, "xmlns", "http://www.w3.org/2000/svg"),
        (B.disabled = L = e[8] > 1 && !0),
        o(B, "data-tooltip", "Promover"),
        o(
          B,
          "class",
          "w-7 h-7 grid place-items-center disabled:opacity-0 disabled:cursor-default bg-[#00BC7E]/[0.08] active:hover:bg-[#00BC7E]/[0.18] rounded svelte-tjh505"
        ),
        o(y, "stroke", "#FEE440"),
        o(y, "stroke-width", "2"),
        o(y, "stroke-linecap", "round"),
        o(y, "stroke-linejoin", "round"),
        o(
          y,
          "d",
          "M11 4.58329L11 17.4166M11 17.4166L17.4167 11M11 17.4166L4.58335 11"
        ),
        o(E, "class", "w-[1.375rem] h-[1.375rem] fill-none"),
        o(E, "viewBox", "0 0 22 22"),
        o(E, "xmlns", "http://www.w3.org/2000/svg"),
        (b.disabled = K = e[8] > 1 && !0),
        o(b, "data-tooltip", "Rebaixar"),
        o(
          b,
          "class",
          "w-7 h-7 grid place-items-center disabled:opacity-0 disabled:cursor-default bg-[#FEE440]/[0.08] active:hover:bg-[#FEE440]/[0.18] rounded svelte-tjh505"
        ),
        o(J, "stroke", "#F64740"),
        o(J, "stroke-width", "2"),
        o(J, "stroke-linecap", "round"),
        o(J, "stroke-linejoin", "round"),
        o(J, "d", "M16.5 5.5L5.5 16.5M5.5 5.5L16.5 16.5"),
        o(P, "class", "w-[1.375rem] h-[1.375rem] fill-none"),
        o(P, "viewBox", "0 0 22 22"),
        o(P, "xmlns", "http://www.w3.org/2000/svg"),
        (w.disabled = te = e[8] > 1 && !0),
        o(w, "data-tooltip", "Remover"),
        o(
          w,
          "class",
          "w-7 h-7 grid place-items-center disabled:opacity-0 disabled:cursor-default bg-[#F64740]/[0.08] active:hover:bg-[#F64740]/[0.18] rounded svelte-tjh505"
        ),
        o(
          O,
          "class",
          "w-[6.25rem] absolute right-[1.6875rem] flex items-center space-x-2"
        ),
        o(
          t,
          "class",
          "w-[21.375rem] h-[6.875rem] relative flex items-center justify-evenly bg-black/50 rounded"
        );
    },
    m(se, G) {
      q(se, t, G),
        i(t, n),
        i(t, s),
        i(t, c),
        i(c, l),
        i(l, u),
        i(u, d),
        i(u, f),
        i(l, a),
        i(l, m),
        i(c, _),
        i(c, M),
        i(M, C),
        i(c, T),
        i(c, S),
        i(S, F),
        i(t, Z),
        i(t, O),
        i(O, B),
        i(B, A),
        i(A, V),
        i(O, N),
        i(O, b),
        i(b, E),
        i(E, y),
        i(O, I),
        i(O, w),
        i(w, P),
        i(P, J),
        i(t, be),
        ce ||
          ((g = [W(B, "click", U), W(b, "click", Q), W(w, "click", X)]),
          (ce = !0));
    },
    p(se, G) {
      (e = se),
        G[0] & 32 &&
          r !==
            (r =
              "w-2 h-2 absolute mt-1 left-[1.1875rem] " +
              (e[37].online
                ? "bg-[#00BC7E] [box-shadow:0_0_0.625rem_rgba(245,10,70,0.4)]"
                : "bg-[#F64740] [box-shadow:0_0_0.625rem_rgba(246,71,64,0.4)]") +
              " rounded-[0.1875rem]") &&
          o(n, "class", r),
        G[0] & 32 && h !== (h = e[37].id + "") && z(f, h),
        G[0] & 32 && v !== (v = e[37].name + "") && z(m, v),
        G[0] & 32 && j !== (j = e[37].phone + "") && z(C, j),
        G[0] & 32 && R !== (R = e[37].role + "") && z(F, R),
        G[0] & 256 && L !== (L = e[8] > 1 && !0) && (B.disabled = L),
        G[0] & 256 && K !== (K = e[8] > 1 && !0) && (b.disabled = K),
        G[0] & 256 && te !== (te = e[8] > 1 && !0) && (w.disabled = te);
    },
    d(se) {
      se && H(t), (ce = !1), $(g);
    },
  };
}
function Lt(e) {
  let t,
    n = e[0] && Pe(e);
  return {
    c() {
      n && n.c(), (t = Xe());
    },
    m(r, s) {
      n && n.m(r, s), q(r, t, s);
    },
    p(r, s) {
      r[0]
        ? n
          ? n.p(r, s)
          : ((n = Pe(r)), n.c(), n.m(t.parentNode, t))
        : n && (n.d(1), (n = null));
    },
    i: re,
    o: re,
    d(r) {
      n && n.d(r), r && H(t);
    },
  };
}
function Et(e, t, n) {
  let r = location.port === "5173" || !1,
    [s, c, l, u] = [!0, !1, !1, 0],
    [d, h, f] = [[], [], []],
    [a, v, m, _, M] = [void 0, 0, void 0, void 0, void 0],
    [j, C] = ["Depositar", "Sacar"];
  gt("open", (g) => {
    n(0, (r = !0)),
      n(14, (h = g[1])),
      n(3, (l = g[2])),
      n(4, (u = g[3])),
      n(8, (v = g[0].client_role)),
      n(7, (a = g[0].groupName)),
      n(5, (d = g[0].members)),
      S();
  }),
    window.addEventListener(
      "keydown",
      (g) => g.key === "Escape" && (ee("close", n(0, (r = !1))), T())
    );
  function T() {
    n(1, ([s, m, _] = [!0, void 0, void 0]), s, n(9, m), n(10, _)),
      n(12, ([j, C] = ["Depositar", "Sacar"]), j, n(13, C));
  }
  function S() {
    n(5, (d = d.sort((g, U) => (g.role_id > U.role_id ? 1 : -1))));
  }
  async function R() {
    const g = await ee("buy");
    g != !1 && n(3, (l = g));
  }
  async function F(g) {
    const U = await ee("invite", { user_id: g });
    U != !1 && (n(5, (d = d.concat(U))), S());
  }
  async function Z(g) {
    const U = await ee("dismiss", { user_id: g }),
      Q = d.filter((X) => X.id != g);
    U && (n(5, (d = Q)), S());
  }
  async function O(g, U) {
    const Q = await ee(g, { user_id: U });
    Q != !1 &&
      (n(
        5,
        (d = d.map(
          (X) => (X.id == U && ((X.role = Q[0]), (X.role_id = Q[1])), X)
        ))
      ),
      S());
  }
  async function B(g, U) {
    (await ee(g, { value: U })) != !1 &&
      (n(
        6,
        (f = f.concat({ Type: g == "deposit" ? "entry" : "exit", Value: U }))
      ),
      A());
  }
  async function A() {
    const g = await ee("bank");
    n(11, (M = g.Balance)), n(6, (f = g.Transactions));
  }
  function V(g) {
    tt.call(this, e, g);
  }
  const L = () => !l && n(2, (c = !0)),
    N = () => !l && n(2, (c = !1)),
    b = () => R(),
    E = () => n(1, (s = !0)),
    y = () => (n(1, (s = !1)), A());
  function K() {
    (m = pe(this.value)), n(9, m);
  }
  const I = () => {
      m != null && (F(m), n(9, (m = void 0)));
    },
    w = (g) => O("promote", g.id),
    P = (g) => O("demote", g.id),
    J = (g) => Z(g.id);
  function te() {
    (_ = pe(this.value)), n(10, _);
  }
  return [
    r,
    s,
    c,
    l,
    u,
    d,
    f,
    a,
    v,
    m,
    _,
    M,
    j,
    C,
    h,
    R,
    F,
    Z,
    O,
    B,
    A,
    V,
    L,
    N,
    b,
    E,
    y,
    K,
    I,
    w,
    P,
    J,
    te,
    () => n(12, ([j, C] = [C, j]), j, n(13, C)),
    () => {
      _ != null &&
        (B(j == "Depositar" ? "deposit" : "withdraw", _), n(10, (_ = void 0)));
    },
  ];
}
class xt extends ft {
  constructor(t) {
    super(), ut(this, t, Et, Lt, Je, {}, null, [-1, -1]);
  }
}
new xt({ target: document.getElementById("app") });
